<?php
include("AndroidPush.php");
include("iOSpush.php");

class Push
{


      public static function adminPush($push1, $msg) {
     global $db; 

    
$push = $push1['android_push'];
$push2 = $push1['ios_push'];

$msg1 = array();
$mes = $db->getRows("SELECT * FROM messages WHERE toUser = ? and new = 1", array($push1['id']));
$msg1['badge'] = count($mes);
$msg1['push'] = $msg;
$msg1['type'] = 0;
if(strlen($push) > 0) {
AndroidPush::sendToUsers(array($push), $msg1);
} 

if(strlen($push2) > 0) {

   // print_r($msg1);
   iOSpush::sendToUsers(array($push2), $msg1); 
}
     

    }


    public static function sendPush($user, $type) {
     global $db; 

     if($type == "message")
     {
$message = $db->getRow("SELECT * FROM messages WHERE toUser = ? ORDER BY id DESC", array($user));
$fromUser = $db->getRow("SELECT * FROM users WHERE id = ?", array($message['user']));
//$fromUser = $message['user'];
$push = $fromUser['first_name']." ".$fromUser['last_name']." - Sent you a message '".$message['text']."'";
$msg = array("type"=>1, "message"=>$message['text'],"push"=>$push, "fromUser"=>$fromUser);



$push1 = $db->getRow("SELECT * FROM users WHERE id = ?", array($user));

if($push1['hidden'] == 0) { //If is not blocked
$push = $push1['android_push'];
$push2 = $push1['ios_push'];

$mes = $db->getRows("SELECT * FROM messages WHERE toUser = ? and new = 1", array($user));
$msg['badge'] = count($mes);
if(strlen($push) > 0) {
AndroidPush::sendToUsers(array($push), $msg);
} 

if(strlen($push2) > 0) {
   iOSpush::sendToUsers(array($push2), $msg); 
}
}
     }

    }

    public static function expire($user)
    {

        if($user['hidden'] == 0) { //If is not blocked
        $push = $user['android_push'];
$push2 = $user['ios_push'];


$msg = array();
$msg['push'] = "You subscription expire in 2 days";
$msg['message'] = $msg['push'];

$mes = $db->getRows("SELECT * FROM messages WHERE toUser = ? and new = 1", array($user['id']));
$msg['badge'] = count($mes);

        if(strlen($push) > 0) {
AndroidPush::sendToUsers(array($push), $msg);
} 

if(strlen($push2) > 0) {
   iOSpush::sendToUsers(array($push2), $msg); 
}
        }
    }

     public static function sendOffer($user,$job, $type, $offer, $type2 = "") {
    global $db; 


$j1 =json_encode($job);
 $myfile = fopen("log.txt", "a") or die("Unable to open file!");
    $date = date("Y/m/d")." ".date("h:i:sa");
$txt = "[$date] User- ".$user." Pass -".$j1.", Type - ".$type." Offer ".$offer." Type2 ".$type2;

fwrite($myfile, "\n". $txt);
fclose($myfile);



$offer = $db->getRow("SELECT * FROM offers WHERE id = ?", array($offer));
if($job['byUser'] == $user)
{
//SHould to clean

if($type2 == 1 && $type== "offer_job" || $type2 == 0 && $type == "offer_accept" || $type2 == 0 && $type == "offer_refuse")
{
$push1 = $db->getRow("SELECT * FROM users WHERE id = ?", array($offer['userid']));
     $fromUser = $db->getRow("SELECT * FROM users WHERE id = ?", array($job['byUser']));
} else {
     $fromUser = $db->getRow("SELECT * FROM users WHERE id = ?", array($offer['userid']));
    $push1 = $db->getRow("SELECT * FROM users WHERE id = ?", array($job['byUser']));
}

} else {

if($type2 == 1 && $type== "offer_job" || $type2 == 0 && $type == "offer_accept" || $type2 == 0 && $type == "offer_refuse")
{
$push1 = $db->getRow("SELECT * FROM users WHERE id = ?", array($user));
     $fromUser = $db->getRow("SELECT * FROM users WHERE id = ?", array($job['byUser']));
} else {
     $fromUser = $db->getRow("SELECT * FROM users WHERE id = ?", array($user));
    $push1 = $db->getRow("SELECT * FROM users WHERE id = ?", array($job['byUser']));
    
}


}

if($push1['hidden'] == 0) { //If is not blocked
$push = $push1['android_push'];
$push2 = $push1['ios_push'];

$msg = array();



$mes = $db->getRows("SELECT * FROM messages WHERE toUser = ? and new = 1", array($user));
$msg['badge'] = count($mes);


$msg['fromUser'] = $fromUser;
$msg['job'] = $job;

if($type == "offer_accept")
{
$msg['type'] = 2;
$msg['message'] = "Your offer was accepted";
$push = $fromUser['first_name']." ".$fromUser['last_name']." - Was accepted your offer";
$msg['push'] = $push;
}


if($type == "offer_refuse")
{
$msg['type'] = 3; 
$msg['message'] = "Your offer was refused";
$push = $fromUser['first_name']." ".$fromUser['last_name']." - Was refused your offer";
$msg['push'] = $push;
}


if($type == "offer_job")
{
$msg['type'] = 4;
$msg['message'] = "You received an offer";
$push = $fromUser['first_name']." ".$fromUser['last_name']." - Send you and offer";
$msg['push'] = $push;
}
// $push = $db->getRow("SELECT * FROM users WHERE id = ?", array($user));
// $push = $push['android_push'];


if(strlen($push) > 0) {
AndroidPush::sendToUsers(array($push), $msg);
} 

if(strlen($push2) > 0) {
    $msg['type'] = 2; //JUST FOR IOS
   iOSpush::sendToUsers(array($push2), $msg); 
}

}

     }


}