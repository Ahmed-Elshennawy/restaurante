<?php

include '../config/db.php';

$title = filterReq("item_name");
$detail = filterReq("item_detail");
$price = filterReq("item_price");
$category = filterReq("item_category");
$imagename = imageUpload("file");

if($imagename != 'fail'){
$stmt = $con->prepare('INSERT INTO `items` (`item_name`, `item_price`, `item_detail`, `item_category`, 
                        `item_image`) VALUES (? , ? , ?, ?, ?)');

$stmt->execute(array($title,$price,$detail,$category,$imagename));
$count = $stmt->rowCount(); 
if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}
}else{
    echo json_encode(array("status" => "fail"));
}
