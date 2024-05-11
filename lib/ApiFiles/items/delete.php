<?php

include '../config/db.php';

$itemid = filterReq("id");
$img = filterReq("file");

$stmt = $con->prepare("DELETE FROM items WHERE `id` = ?");

$stmt->execute(array($itemid));
$count = $stmt->rowCount();

if($count > 0){
    deleteFile("upload" , $img);
    echo json_encode(array("status"=>"success"));
}else{
    echo json_encode(array("status"=>"fail"));
}