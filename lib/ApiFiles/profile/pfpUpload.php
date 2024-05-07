<?php

include '../config/db.php';

$id = filterReq("id");
$imagename = imageUpload("file");

if($imagename != 'fail'){
    $stmt = $con->prepare("UPDATE users SET `profile_pic_name` = ? where `id` = ? ");

    $stmt->execute(array($imagename,$id));
    $count = $stmt->rowCount();

    if($count > 0){
        echo json_encode(array("status"=>"success", $imagename));
    }else{
        echo json_encode(array("status"=>"fail"));
    }
}else{
    echo json_encode(array("status" => "fail"));
}