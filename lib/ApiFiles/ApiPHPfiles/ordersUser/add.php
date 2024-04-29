<?php

include '../config/db.php';

// $title = filterReq("title");
// $detail = filterReq("detail");
// $userid = filterReq("id");
// $price = filterReq("price");
// $quantity = filterReq("quantity");
// $time = filterReq("time");
// $imagename = imageUpload("image");

// if($imagename != 'fail'){
// $stmt = $con->prepare('INSERT INTO `orders` (`order_title`, `order_detail`, `order_user_id`, 
//                         `order_price`, `order_quantity`, `order_time`, `order_image`) VALUES (? , ? , ?, ? , ?, ?, ?)');

// $stmt->execute(array($title,$detail,$userid,$price,$quantity, $time,$imagename));\


$title = filterReq("title");
$detail = filterReq("detail");
$price = filterReq("price");
$imagename = imageUpload("image");

if($imagename != 'fail'){
$stmt = $con->prepare('INSERT INTO `items` (`item_name`, `item_price`, `item_detail`, `item_category`, 
                        `item_image`) VALUES (? , ? , ?, 1, ?)');

$stmt->execute(array($title,$detail,$price,$imagename));
$count = $stmt->rowCount();
if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}
}else{
    echo json_encode(array("status" => "fail"));
}