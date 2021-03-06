#!/bin/sh

# platform choice
macPath=/Users/libingtao/Applications/elasticsearch-jdbc-2.1.1.2
linuxPath=/home/bingtaoli/elasticsearch-jdbc-2.1.1.2
if [ -d $macPath ]; then
	echo "it is on mac platform"
	export JDBC_IMPORTER_HOME=$macPath
elif [ -d $linuxPath ]; then
	echo "it is on linux platform"
	export JDBC_IMPORTER_HOME=$linuxPath
else 
	#退出
	echo "no right elastic search jdbc directory"
	exit 1
fi

#新删除所有的数据
#curl -XDELETE 'http://localhost:9200/zuiwan'

bin=$JDBC_IMPORTER_HOME/bin
lib=$JDBC_IMPORTER_HOME/lib
echo $bin
echo '
{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:mysql://localhost:3306/zuiwan_m",
        "user" : "root",
        "password" : "",
        "sql" : "select id, article_title, article_content from article" ,
        "index" : "zuiwan",
        "type" : "article"
    }
}'  | java \
              -cp "${lib}/*" \
              -Dlog4j.configurationFile=${bin}/log4j2.xml \
              org.xbib.tools.Runner \
              org.xbib.tools.JDBCImporter
echo "sleeping while importer should run..."
sleep 5
curl -XGET 'localhost:9200/zuiwan/article/_search?pretty&q=*'
