<?php
/**
 * Created by PhpStorm.
 * User: bingtaoli
 * Date: 2015/9/20
 * Time: 12:35
 * 负责session的处理，只针对session,不和数据库交互
 */
class ZW_client{

    public function login($username){
        $_SESSION['zw_username'] = $username;
        return;
    }

    public function login_check(){
        if (isset($_SESSION['zw_username'])){
            return true;
        }
        return false;
    }

    public function get_session_client(){
        $username = isset($_SESSION['zw_username']) ? $_SESSION['zw_username'] : null;
        return $username;
    }

    public function logout(){
        if (isset($_SESSION['zw_username'])){
            unset($_SESSION['zw_username']);
        }
    }
}