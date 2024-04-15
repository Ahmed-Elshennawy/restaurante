<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Headers: X-Requested-With");

include '../config/db.php';

$orderid = filterReq("id");
$title = filterReq("title");
$content = filterReq("content");
$price = filterReq("price");
$amount = filterReq("amount");

$stmt = $con->prepare('UPDATE orders SET `order_title` = ? , `order_content` = ? , `order_price` = ?, `order_amount` = ? where `order_id` = ?');

$stmt->execute(array($title,$content,$price,$amount,$orderid));
$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}