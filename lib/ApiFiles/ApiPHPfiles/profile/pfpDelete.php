<?php

include '../config/db.php';

$id = filterReq("id");
$imagename = filterReq("file");

$stmt = $con->prepare("UPDATE `users` SET `profile_pic_name` = '' WHERE `id` = ?");

$stmt->execute(array($id));
$count = $stmt->rowCount();

if($count > 0){
    deleteFile("../profile/upload/" , $imagename);
    echo json_encode(array("status" => "success"));
}else{
    echo json_encode(array("status" => "fail"));
}
