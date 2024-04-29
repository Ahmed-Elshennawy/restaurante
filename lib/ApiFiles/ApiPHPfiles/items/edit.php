<?php

include '../config/db.php';

$orderid = filterReq("id");
$price = filterReq("price");
$quantity = filterReq("quantity");
$time = filterReq("time");

$stmt = $con->prepare(" UPDATE orders SET `order_price` = ?, `order_quantity` = ?, `order_time` = ? where `id` = ? ");

$stmt->execute(array($price,$quantity,$time,$orderid));
$count = $stmt->rowCount();

if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}