<?php
include("db.php");
include("iOSpush.php");

// define( 'API_ACCESS_KEY', 'AIzaSyBYS-fIk4u_zCUBr7YOo0tPDznYahVaefY' );


// // $url      = 'http://www.geoplugin.net/extras/location.gp?lat=46.9919628&long=28.8572613&format=json';
// // $response = json_decode(file_get_contents($url));

// // echo $response->geoplugin_region;
// // echo $response->geoplugin_countryCode;
// //print_r($response);


// // // API access key from Google API's Console
// // define( 'API_ACCESS_KEY', 'AIzaSyB4UJFL_QLrjq_sTDoDqph5gf1aHHI4aOo' );


// $fromUser = $db->getRow("SELECT * FROM users WHERE id = ?", array(13));
// ///$fromUser = $message['user'];

// $msg = array("type"=>1, "message"=>"21312", "fromUser"=>$fromUser);

// print_r($msg);

// //for($i = 0; $i<100;$i++) {
// AndroidPush::sendToUsers(array("APA91bHSkZmrEwEzPTmDBGOadr7jdIFDQS7-LAHv3QY5vvFbVM0WkApcqFtP1dX1n98pT3NC8K-LSecGi4Ifa97eVjKVHuXHo4ktkpdVmlVYxcEPg1mDNn8EGFNKxQ3eHeeyBE7umrRl"), $msg);
// //}
// class AndroidPush
// {



// public static function sendToUsers($registrationIds,$msg)
// {
// // prep the bundle

// $fields = array
// (
// 	'registration_ids' 	=> $registrationIds,
// 	'data'			=> $msg
// );
 
// $headers = array
// (
// 	'Authorization: key=' . API_ACCESS_KEY,
// 	'Content-Type: application/json'
// );
 
// $ch = curl_init();
// curl_setopt( $ch,CURLOPT_URL, 'https://android.googleapis.com/gcm/send' );
// curl_setopt( $ch,CURLOPT_POST, true );
// curl_setopt( $ch,CURLOPT_HTTPHEADER, $headers );
// curl_setopt( $ch,CURLOPT_RETURNTRANSFER, true );
// curl_setopt( $ch,CURLOPT_SSL_VERIFYPEER, false );
// curl_setopt($ch, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4 );
// curl_setopt( $ch,CURLOPT_POSTFIELDS, json_encode( $fields ) );
// $result = curl_exec($ch );
// curl_close( $ch );
// echo $result;

// } 


//}
if($_GET['expire'] > 0)
{
$db->updateRow("UPDATE users SET expire = '2016-10-24' WHERE id = $_GET[expire]");

} else {
$token =  $_GET['token'];
iOSpush::sendToUsers(array($token), "Demo Push");
}

?>