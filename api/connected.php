<?php
header("Access-Control-Allow-Origin: *");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
header("content-type:text/javascript;charset=utf-8");
$connection = mysqli_connect('localhost', 'master', '1111', "kbshopping");
