<?php

include '../config/db.php';

$name = filterReq("order_name");
$detail = filterReq("order_detail");
$price = filterReq("order_price");
$quantity = filterReq("order_quantity");
$date = filterReq("order_date");
$img = filterReq("file");
$userid = filterReq("id");

$stmt = $con->prepare('INSERT INTO `checkout_orders` (`order_name`, `order_detail`,
    `order_price`, `order_quantity`, `order_date`, `order_image` , `user_id`)
    VALUES ( ? ,  ?, ? , ?, ?, ?,?)');

$stmt->execute(array($name,$detail,$price,$quantity, $date, $img,$userid));

$count = $stmt->rowCount();
if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}