<?php

include '../config/db.php';

$title = filterReq("order_name");
$detail = filterReq("order_detail");
$userid = filterReq("id");
$price = filterReq("order_price");
$quantity = filterReq("order_quantity");
$time = filterReq("order_time");
$imagename = imageUpload("file");

if($imagename != 'fail'){
    $stmt = $con->prepare('INSERT INTO `orders` (`order_name`, `order_detail`, `order_image`
                `order_price`, `order_quantity`, `order_user_id`,`order_time`) VALUES ( ? , ?, ?, ? , ?, ?, ?)');

    $stmt->execute(array($title,$detail,$imagename,$price,$quantity, $userid,$time));
    $count = $stmt->rowCount();
    if($count > 0){
        echo json_encode(array("status"=>"success"));
    }else{
        echo json_encode(array("status"=>"fail"));
    }
}else{
    echo json_encode(array("status" => "fail"));
}
