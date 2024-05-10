<?php

include '../config/db.php';


$title = filterReq("item_name");
$detail = filterReq("item_detail");
$price = filterReq("item_price");
$category = filterReq("item_category");
$time = filterReq("item_time");
$itemid = filterReq("id");

$stmt = $con->prepare('UPDATE `items` SET `item_name` = ?, `item_price` = ?, `item_detail` = ? , `item_category` = ? ,`item_time` = ? WHERE id = ?');

$stmt->execute(array($title,$price,$detail,$category,$time,$itemid));
$count = $stmt->rowCount(); 
if($count > 0){
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}
