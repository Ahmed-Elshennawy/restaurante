<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

include '../config/db.php';

$title = filterReq("title");
$content = filterReq("content");
$userid = filterReq("id");
$price = filterReq("price");
$amount = filterReq("amount");

$stmt = $con->prepare('INSERT INTO `orders` (`order_title`, `order_content`, `order_user`, `order_price`, `order_amount`) VALUES (? , ? , ?, ? , ?)');
$stmt->execute(array($title,$content,$userid,$price,$amount));

$count = $stmt->rowCount();
if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}