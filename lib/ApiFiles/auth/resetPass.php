<?php


include '../config/db.php';

$email = filterReq("email");
$password = filterReq("password");

$stmt = $con->prepare("UPDATE users SET  `password` = ? where `email` = ?");
$stmt->execute(array($password,$email));

$count = $stmt->rowCount();
if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}
