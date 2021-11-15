<?php
include 'connected.php';
header("Access-Control-Allow-Origin: *");

if (!$connection) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;

    exit;
}

if (!$connection->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $connection->error);
    exit();
}

if (isset($_GET)) {
    if ($_GET['isAdd'] == 'true') {

        $name = $_GET['name'];
        $usertype = $_GET['usertype'];
        $address = $_GET['address'];
        $phone = $_GET['phone'];
        $email = $_GET['user'];
        $password = $_GET['password'];
        $avatar = $_GET['avatar'];
        $lat = $_GET['lat'];
        $lng = $_GET['lng'];


        $sql = "INSERT INTO `user`(`id`, `name`, `usertype`, `address`, `phone`, `email`, `password`, `avatar`, `lat`, `lng`)
        VALUES (NUll,'$name','$usertype','$address','$phone','$email','$password','$avatar','$lat','$lng')";

        $result = mysqli_query($connection, $sql);

        if ($result) {
            echo "true";
        } else {
            echo "false";
        }
    } else echo "Welcome to Inset Data";
}
mysqli_close($connection);
