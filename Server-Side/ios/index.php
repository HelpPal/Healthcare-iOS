<?php
$debug = false;

if(isset($_POST['debug'])) {
$debug = true;
}

if($debug) {
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
}



include("../db.php");
include("../User.php");
include("../Mail.php");
include("../Job.php");
include("../Offer.php");
include("../Push.php");
header('Content-Type: application/json');


 
$key = 'DA8B9B217DE9E123';


function generateRandomString($length = 10) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}







function email($to, $subject, $message)
{
mail($to,$subject,$message);
}

function decrypt_string($pass,$key)
{

$base64encoded_ciphertext = $pass;

$res_non = mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $key, base64_decode($base64encoded_ciphertext), 'ecb');

$decrypted = $res_non;
$dec_s2 = strlen($decrypted);

$padding = ord($decrypted[$dec_s2-1]);
$decrypted = substr($decrypted, 0, -$padding);

return  $decrypted;
}

function string_to_array($string)
{
    $response = array();
    
    $strings = explode("|,',|", $string);
    
    foreach($strings as $string)
    {
        if(strlen($string) > 2 ) {
        $object = explode("|12:12|", $string);
        
        $response[$object[0]] = $object[1];
        }
    }
    
    return $response;
}

function return_json($response, $error = "")
{
  return array("response"=>$response, "error"=>$error);
}

$string = decrypt_string($_POST['data'],$key);

$POST = string_to_array($string);


if($debug) {
print_r($POST);
}
/////// CONFIG ///////
$username =  $POST['login'];
$password = $POST['password'];
$debug    = false;



if($POST['api_key'] == "kasld1>!<123kml1") {

date_default_timezone_set('Europe/London');
// echo $POST['request_time'];
// echo "</br>";
// echo time();

//+3600 fix :D on serverside
// print_r(time());
// print_r($POST['request_time']);


 
   $paginationLimit = 10;
    $paginationOffset = $paginationLimit*$POST['page'];
$POST['email'] = strtolower($POST['email']);


switch ($_GET['mode']) {
case "addRating":
$rating = $db->getRows("SELECT * FROM rating WHERE to_user = ? AND user_id = ? AND type = ?", array($POST['toUser'], $POST['userid'], $POST['type']));
if(count($rating)> 0)
{
$db->updateRow("UPDATE rating SET rating = ? WHERE to_user = ? AND user_id = ? AND type = ?", array($POST['rating'],$POST['toUser'], $POST['userid'], $POST['type']));
} else {
$db->insertRow("INSERT INTO rating (to_user,user_id, rating, type) VALUES (?,?,?, ?)", array($POST['toUser'], $POST['userid'], $POST['rating'], $POST['type']));
}
$json = return_json(true, "");
break;
case "skills":
if(!empty($POST['userid']))
{

    $skill = $db->getRows("SELECT * FROM skills");
   $user = $db->getRow("SELECT * FROM users WHERE id =?", array($POST['userid']));
  $other_skils = explode(",",$user['other_skills']);
foreach($other_skils as $skil)
{
    if(strlen($skil) > 0) {
        $skill[] = array("id"=>35, "name"=>$skil);   
           } 
}

    $json = return_json($skill, "");
} else {
    $skill = $db->getRows("SELECT * FROM skills");
    $json = return_json($skill, "");
}
break;






case "terms":
$terms = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non ex id nisi fringilla tincidunt. Donec finibus eros eget congue iaculis. Ut fermentum risus maximus ipsum ultrices eleifend. Nullam lobortis, velit sit amet dictum semper, velit risus luctus dolor, id cursus nulla felis ut neque. Nullam auctor neque neque, vel gravida ipsum hendrerit eget. Phasellus urna felis, sodales malesuada massa eget, rutrum molestie risus. Aliquam erat volutpat. Nunc consectetur pellentesque magna, vitae faucibus felis pharetra eu. Etiam ut eros orci.

Fusce consequat nibh id quam rutrum sagittis. Etiam euismod mi scelerisque elit tristique dignissim. Cras ultricies commodo ex, ac tempor ligula porta ut. Vestibulum imperdiet pharetra malesuada. Donec eget libero est. Vestibulum id tellus in ipsum feugiat scelerisque id sit amet odio. In eu lacus nisl. Nam sed ullamcorper urna, eget gravida dui.

Integer tempor ultricies justo, sed semper lectus dignissim eu. Praesent laoreet orci eu nulla aliquet placerat. Duis eu faucibus velit. Donec sagittis dictum nisi eu faucibus. Morbi eros est, venenatis quis justo nec, vehicula consequat sapien. Praesent a urna facilisis, egestas nulla nec, euismod massa. Duis scelerisque, libero ac maximus venenatis, orci felis egestas lectus, faucibus tincidunt quam nunc quis quam. Etiam mollis ante nunc, nec vehicula augue mollis eget. Morbi at magna sit amet ex rutrum mollis. Aliquam aliquet ipsum tempus, maximus mi sit amet, ullamcorper risus. Nulla pharetra malesuada risus ut commodo. Etiam egestas mi et augue maximus, eu mollis nunc pellentesque.

Praesent tincidunt varius orci non efficitur. Donec varius tortor vitae hendrerit commodo. Aenean id elit non dui finibus cursus nec vitae magna. Etiam id tellus vel magna pharetra imperdiet a quis ipsum. Duis sit amet feugiat arcu. Praesent neque augue, pellentesque vitae dignissim id, pretium sit amet justo. Vestibulum molestie pretium nisl quis aliquet.

Nunc vehicula augue id ipsum fermentum, sit amet elementum arcu laoreet. In eu rutrum metus. Suspendisse potenti. Sed nec dolor condimentum nunc posuere suscipit id non arcu. Sed in sodales arcu. Fusce feugiat, purus eu auctor viverra, ex mi vehicula sapien, vitae tincidunt urna neque a ante. Vivamus dignissim quam consequat leo vehicula volutpat. Mauris et dictum nibh. Fusce euismod efficitur efficitur. Nulla maximus mi at felis dapibus laoreet. Praesent ultricies neque sit amet elit porta viverra. Maecenas non fermentum enim.

Curabitur varius scelerisque tortor, eu sollicitudin leo tincidunt at. Nulla gravida molestie mi, eget tempus nunc scelerisque eu. Etiam rhoncus vehicula luctus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Fusce at leo at ante consectetur consectetur eu a justo. Curabitur libero ante, faucibus sed turpis mollis, ultrices volutpat justo. Suspendisse eget accumsan purus. Aliquam sodales neque interdum, porttitor nisl venenatis, aliquam libero. Etiam vehicula interdum maximus. Mauris non ipsum est. Fusce porttitor mauris ut velit pretium, porttitor rhoncus felis iaculis. Praesent eget auctor nisl. Cras in porttitor sem, nec vestibulum quam.

Sed a condimentum risus, id tristique mauris. Aenean enim mauris, condimentum vel nunc in, eleifend mollis nibh. Suspendisse in elementum purus. Vestibulum commodo aliquam sollicitudin. Nam ultricies lacus eu lobortis egestas. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Cras odio tortor, euismod vitae fringilla sed, mollis sit amet velit. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Curabitur ut placerat purus, in posuere orci. Duis et sem lacinia, venenatis tellus eu, aliquet nisi. Vestibulum sed tempus elit. Curabitur non fermentum diam. Duis ac mollis neque. Nulla dictum egestas lacus, at vestibulum urna vehicula in.

Morbi congue accumsan lacus, in pulvinar neque facilisis vel. Nulla fermentum quam sed quam fermentum blandit. Mauris augue felis, efficitur in justo id, tempus imperdiet tellus. Pellentesque posuere, tortor ut blandit elementum, turpis est rutrum sapien, at lobortis velit massa id enim. Ut ac nunc mauris. Cras euismod, lorem ut finibus elementum, risus erat accumsan metus, et consequat lacus arcu sit amet mauris. Vivamus a odio dui. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo orci quis velit scelerisque, ac commodo massa pulvinar. Praesent quis tempus libero, id bibendum nisi. Curabitur mi eros, dictum a turpis at, fringilla scelerisque elit.

Sed et sem scelerisque, ornare elit sit amet, luctus lectus. Etiam eget pharetra dolor. Nam in ante a elit iaculis facilisis eu quis enim. Vivamus in suscipit odio. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Quisque quis feugiat sem. Phasellus eu blandit odio. Praesent varius varius nibh, non mollis ipsum sodales id. Morbi commodo, risus quis posuere lacinia, orci nunc pulvinar nisl, varius dictum lorem purus iaculis justo. Nullam ac risus justo. Morbi id nulla urna. Etiam non velit dignissim, pulvinar arcu ac, luctus ipsum.

Sed tellus eros, rhoncus sit amet lobortis a, aliquet ut augue. Nulla quis sapien sed mi blandit imperdiet at vel lectus. Maecenas porta rhoncus bibendum. Sed ornare vestibulum nibh, sed lobortis orci ultrices nec. Morbi maximus, massa eu ornare consequat, risus est convallis enim, ut lobortis velit est eget nisl. Mauris eget nulla at lectus sagittis feugiat. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vestibulum ultricies nibh sed risus hendrerit, vel sollicitudin nibh pulvinar. Donec sollicitudin magna sem, vel aliquet purus egestas eu. Sed pretium tellus ac euismod tincidunt. Sed a metus gravida tortor tincidunt malesuada.

";
$json = return_json($terms, "");
break;



case "login":

//print_r($POST);
$user = $db->getRow("SELECT * FROM users WHERE email = ? and password = ?", array(strtolower($POST['username']), $POST['password']));

$error = "";
if(!$user){ $error = "User or password are incorrect";} else  {
//$user['skills'] = User::skills($user['id']);
if($user['hidden'] == 0) {
$user = User::profile($user['id'], "id");
} else {
    $error = "Your account was blocked";
}
}
$json = return_json($user, $error);
break;

case "recover":

$user = $db->getRow("SELECT * FROM users WHERE email = ?", array($POST['email']));




$error = "";
if(!$user){ $error1 = "Not found any user with this email";} else { $user1 = "Check your email";  Mail::sendMail($user, "recover"); }

$json = return_json($user1, $error);
break;

case "newMess":
$mes = $db->getRows("SELECT * FROM messages WHERE toUser = ? and new = 1", array($POST['userid']));
  $json = return_json(count($mes), "");
break;

case "checkEmail":

if(empty($POST['email']))
{
  $json = return_json("0", "Please fill 'email' field");
} else {
$check = $db->getRows("SELECT * FROM users WHERE  email = ?", array($POST['email']));


if(count($check) == 0) {
  $json = return_json("0", "");
} else {
  $json = return_json("1", "User with this email already exist");
}
}
break;

case "register":
// print_r($POST);
$registered = false;
if(empty($POST['email']))
{
  $json = return_json("0", "Please fill 'email' field");
} elseif(strlen($POST['type']) == 0)
{
  $json = return_json("0", "Please fill 'type' field");

}elseif(empty($POST['password']))
{
  $json = return_json("0", "Please fill 'password' field");
}elseif(empty($POST['first_name']))
{
  $json = return_json("0", "Please fill 'first_name' field");
}elseif(empty($POST['last_name']))
{
  $json = return_json("0", "Please fill 'last_name' field");
}elseif(empty($POST['lat']))
{
  $json = return_json("0", "Please fill 'lat' field");
}elseif(empty($POST['lat']))
{
  $json = return_json("0", "Please fill 'long' field");
} 
else {





$check = $db->getRows("SELECT * FROM users WHERE   email = ?", array($POST['email']));






if(count($check) == 0) {



if(strlen($POST['zip']) > 0) {
    $zip = $POST['zip'];
    } else {
        $zip = "";
    }
    


   


   // $place = get_location($POST['lat'], $POST['long']);
if(strlen($POST['city']) > 0) {
$city = $POST['city'];
} else {
    $city = "";
}

if(strlen($POST['state']) > 0) {
$state = $POST['state'];
} else {
    $state = "";
}

if(strlen($POST['adress']) > 0) {
$addres = $POST['adress'];
} else {
    $addres = "";
}


 $desc = $POST['description'];

 if(strlen($desc) == 0)
 {
     $desc = " ";
 }


if($POST['type'] == 0 )
{


   




    $phone = $POST['phone'];
$registered = true;
$other = $POST['other_skills'];
if(strlen($other) == 0)
{
$other =  "";
}

$db->insertRow("INSERT INTO users  (type,password, email, first_name, last_name,address_lat, address_long,description, city, state, address, other_skills, zip, phone) VALUES (0,?,?,?,?,?,?,?,?,?,?,?,?,?)", array($POST['password'], $POST['email'], $POST['first_name'], $POST['last_name'], $POST['lat'], $POST['long'],$desc,$city,$state,$addres,$other,$zip,$phone));

} else {


    if(strlen($POST['experience'])== 0)
{
  $json = return_json("0", "Please fill 'experience' field");
} elseif(strlen($POST['avalable']) == 0)
{
 $json = return_json("0", "Please fill 'avalable' field");
}  elseif(empty($POST['price_min']))
{
 $json = return_json("0", "Please fill 'price_min' field");
} 
 elseif(empty($POST['price_max']))
{
 $json = return_json("0", "Please fill 'price_max' field");
}   elseif(strlen($POST['gender']) == 0)
{
 $json = return_json("0", "Please fill 'gender' field");
}   elseif(empty($POST['description']))
{
 $json = return_json("0", "Please fill 'description' field");
}  else {

if(empty($POST['birthday']))
    {
        $POST['birthday'] = "";
    } 

$path = "";
if(strlen($POST['profile_img']) > 3) {
      $path = "media/".generateRandomString().".png";
      $path1 = $path;
      
//$mediaIMG= "http://104.131.152.91/$path";
 

 file_put_contents("../".$path,base64_decode($POST['profile_img']));
 }
 $registered = true;
 $phone = $POST['phone'];

 $other = $POST['other_skills'];
 if(strlen($other) == 0)
 {
 $other =  "";
 }



 
 $db->insertRow("INSERT INTO users  (type,password, email, first_name, last_name,address_lat, address_long, experience, available_time, price_min, price_max, phone, birthday, description, gender, profile_img, address,state,city, other_skills, zip) VALUES (1,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", array($POST['password'], $POST['email'], $POST['first_name'], $POST['last_name'], $POST['lat'], $POST['long'], $POST['experience'], $POST['avalable'], $POST['price_min'], $POST['price_max'], $phone,$POST['birthday'], $desc,  $POST['gender'], $path1, $addres,$state,$city, $other,$zip));
$skils= explode(",", $POST['skills']);

}
}


if($registered) {
$user = $db->getRow("SELECT * FROM users WHERE email = ?", array($POST['email']));



if($POST['type'] == 0)
{
 Mail::sendMail($user, "register_simple");
} else {
 Mail::sendMail($user, "register_cna");

 foreach($skils as $skill)
{
    if($skill > 0) {
$db->insertRow("INSERT INTO skills_attribute (skill_id,user_id) VALUES (?,?)", array($skill,$user['id']));
    }
}

}
}

} else {
    if($check[0]['email'] == $POST['email'])
    {
$error = "User with this email already exist";
    }

   
}

if($registered) {
$user = User::profile($user['id'], "id");
 $json = return_json($user, $error);
}
}

break;

case "changepassword":

  if(empty($POST['oldpass']))
{
  $json = return_json("0", "Please fill 'oldpass' field");
} elseif(empty($POST['newpass']))
{
    $json = return_json("0", "Please fill 'newpass' field");
}elseif(empty($POST['id']))
{
    $json = return_json("0", "Please fill 'id' field");
} else {

$oldpassword = $POST['oldpass'];
$newpass = $POST['newpass'];

 if($oldpassword == "d41d8cd98f00b204e9800998ecf8427e") {
    $response = 2;
 } else {
$word = $db->getRow("SELECT * FROM users WHERE id = ?", array($POST['id']));
$currentpassword = $word['password'];
if($oldpassword == $currentpassword)
{

    if($newpass != "d41d8cd98f00b204e9800998ecf8427e") {
    $db->updateRow("UPDATE users SET password = ? WHERE id = ?", array($newpass, $POST['id']));
    $response = 1;
    } else {
$response = 2;
    }
}  else {
    $error = "Old password is wrong";
$response = 0;
}
 }

  $json = return_json($response, $error);
}
break;

case "editprofile":



if(strlen($POST['userid']) == 0)
{
  $json = return_json("0", "Please fill 'userid' field");
} elseif(strlen($POST['type']) == 0)
{
  $json = return_json("0", "Please fill 'type' field");
} elseif(empty($POST['skills']) && $POST['type'] == 1 && empty($POST['other_skills']) )
{
     $json = return_json("0", "Please fill 'skills' field");
}elseif(empty($POST['first_name']))
{
  $json = return_json("0", "Please fill 'first_name' field");
}elseif(empty($POST['last_name']))
{
  $json = return_json("0", "Please fill 'last_name' field");
}elseif(empty($POST['lat']))
{
  $json = return_json("0", "Please fill 'lat' field");
}elseif(empty($POST['lat']))
{
  $json = return_json("0", "Please fill 'long' field");
}  elseif(strlen($POST['experience']) == 0)
{
  $json = return_json("0", "Please fill 'experience' field");
} elseif(empty($POST['avalable']))
{
 $json = return_json("0", "Please fill 'avalable' field");
}  elseif(empty($POST['price_min']))
{
 $json = return_json("0", "Please fill 'price_min' field");
} 
 elseif(empty($POST['price_max']))
{
 $json = return_json("0", "Please fill 'price_max' field");
}  elseif(strlen($POST['gender']) == 0)
{
 $json = return_json("0", "Please fill 'gender' field");
}   elseif(empty($POST['description']))
{
 $json = return_json("0", "Please fill 'description' field");
}  else {



    if(empty($POST['birthday']))
    {
    $POST['birthday'] = "";
    } 

    if(strlen($POST['zip']) > 0) {
        $zip = $POST['zip'];
        } else {
            $zip = "";
        }






//$place = get_location($POST['lat'], $POST['long']);
if(strlen($POST['city']) > 0) {
$city = $POST['city'];
} else {
    $city = "";
}

if(strlen($POST['state']) > 0) {
$state = $POST['state'];
} else {
    $state = "";
}

if(strlen($POST['adress']) > 0) {
$addres = $POST['adress'];
} else {
    $addres = "";
}
$other = $POST['other_skills'];
if(strlen($other) == 0)
{
$other =  "";
}

 $db->updateRow("UPDATE users  SET first_name=?, last_name=?,address_lat=?, address_long=?, experience=?, available_time=?, price_min=?, price_max=?, phone=?, birthday=?, description=?, gender=?, city = ?, address = ?, state = ?, other_skills = ?, zip = ? WHERE id = ?", array($POST['first_name'], $POST['last_name'], $POST['lat'], $POST['long'], $POST['experience'], $POST['avalable'], $POST['price_min'], $POST['price_max'], $POST['phone'],$POST['birthday'], $POST['description'],  $POST['gender'], $city, $addres,$state,$other,$zip, $POST['userid']));
$skils= explode(",", $POST['skills']);



if(strlen($POST['profile_img']) > 3) {
  $path = "media/".generateRandomString().".png";
  $path1 =  $path;
  
//$mediaIMG= "http://midnight.works//appstore/health-care/$path";
 

 file_put_contents("../".$path,base64_decode($POST['profile_img']));

$db->updateRow("UPDATE users SET profile_img = ? WHERE id = ?", array($path1, $POST['userid']));
}

// if($POST['type'] != 0)
// {

if($POST['type']== 1)
{
$db->deleteRow("DELETE FROM skills_attribute WHERE user_id = ?", array($POST['userid']));
 foreach($skils as $skill)
{

    if($skill > 0) {
$db->insertRow("INSERT INTO skills_attribute (skill_id,user_id) VALUES (?,?)", array($skill,$POST['userid']));
    }
}
}
//}
$user = User::profile($POST['userid'], "id");
// $user = $db->getRow("SELECT * FROM users WHERE id = ?", array($POST['id']));
// $user['skills'] = User::skills($user);


  $json = return_json($user, $error);
}

break;
case "deletepush":
if(empty($POST['userid']))
{
    $json = return_json("0", "Please fill 'userid' field");
} else {

$db->updateRow("UPDATE users SET ios_push = '' WHERE id = ?", array($POST['userid']));

$json = return_json("1", "");
}
break;

case "push":
if(empty($POST['userid']))
{
    $json = return_json("0", "Please fill 'userid' field");
}elseif(empty($POST['push']))
{
    $json = return_json("0", "Please fill 'push' field");
} else {


$db->updateRow("UPDATE users SET ios_push = ? WHERE id = ?", array($POST['push'], $POST['userid']));

$json = return_json("1", "");
}
break;

case "setAvalable":

if(empty($POST['userid']))
{
  $json = return_json("0", "Please fill 'userid' field");
}elseif(strlen($POST['mess']) == 0)
{
  $json = return_json("0", "Please fill 'mess' field");
} else {
$db->updateRow("UPDATE users SET available = ? WHERE id= ?", array($POST['mess'],$POST['userid']));
   $json = return_json($POST['mess'], "");
}
break;


case "sendmessage":

if(empty($POST['user']))
{ $json = return_json("0", "Please fill 'user' field"); } elseif(empty($POST['toUser']))
{
$json = return_json("0", "Please fill 'toUser' field");
} elseif(empty($POST['text']))
{
$json = return_json("0", "Please fill 'text' field");
} else {


$conversation = $db->getRows("SELECT * FROM conversations WHERE user = ? and partner = ?", array($POST['user'], $POST['toUser']));
if(count($conversation) == 0)
{
    $db->insertRow("INSERT INTO conversations (user,partner) VALUES (?,?)", array($POST['user'], $POST['toUser']));
      $db->insertRow("INSERT INTO conversations (user,partner) VALUES (?,?)", array($POST['toUser'], $POST['user']));
}
$db->insertRow("INSERT INTO messages (user,toUser,text) VALUES (?,?,?)", array($POST['user'], $POST['toUser'], $POST['text']));
 Push::sendPush($POST['toUser'], "message");

$message = $db->getRow("SELECT * FROM messages WHERE user = ? and toUser = ? ORDER by id DESC",array($POST['user'], $POST['toUser']));
    $json = return_json($message, "");
}
break;

case "messages":

if(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); } else {
$messages = $db->getRows("SELECT * FROM conversations WHERE user = ?", array($POST['userid']));
$newMessages = array();

foreach($messages as $message)
{ 
    $user =  $db->getRow("SELECT * FROM users WHERE id = ?", array($message['partner']));
    $string =$user['first_name']." ".$user['last_name'];
 $message['parner-name'] = $string;

$messag1 = $db->getRow("SELECT * FROM messages WHERE (user = ? and toUser = ?) OR (toUser = ? and user = ?) ORDER by id DESC", array( $message['user'], $message['partner'],  $message['user'], $message['partner']));



$phpdate = strtotime( $messag1['time'] );
$messag1['time'] = date( 'H:i', $phpdate );

$pM = $db->getRows("SELECT * FROM messages WHERE toUser = ? and user = ? and new = 1", array($POST['userid'],$message['partner']));

    $pM = count($pM);
$messag1['new'] = $pM;
$message['last_message']  = $messag1;






$newMessages[] = $message;
}
$json = return_json($newMessages,"");
}
break;

case "conversation":
if(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); }elseif(empty($POST['partnerid']))
{ $json = return_json("0", "Please fill 'partnerid' field"); }  else {



$conversation = $db->getRows("SELECT * FROM messages WHERE (user = ? and toUser = ?) OR (toUser = ? and user = ?)", array($POST['userid'], $POST['partnerid'], $POST['userid'], $POST['partnerid']));
$final = array();
foreach($conversation as $conversion)
{

$phpdate = strtotime( $conversion['time'] );
$conversion['time'] = date( 'H:i', $phpdate );


    $final[] = $conversion;


}


//$mes = $db->getRows("SELECT * FROM messages WHERE toUser = ? and user = ? and new = 1", array($POST['userid'], $POST['partnerid']));

$db->updateRow("UPDATE messages SET new = 0 WHERE toUser = ? and user = ?",array($POST['userid'], $POST['partnerid']));

$json = return_json($final,"");
}
break;



case "deleteconversation":

if(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); }
elseif(empty($POST['conversation_id']))
{ $json = return_json("0", "Please fill 'conversation_id' field"); } else {

$db->updateRow("DELETE FROM conversations WHERE (user = ? and partner = ?) OR (partner = ? and user = ?)", array($POST['userid'], $POST['conversation_id'],$POST['userid'], $POST['conversation_id']));
$db->updateRow("DELETE FROM messages  WHERE (user = ? and toUser = ?) OR (toUser = ? and user = ?)",  array($POST['userid'], $POST['conversation_id'],$POST['userid'], $POST['conversation_id']));
$json = return_json("Conversation  was deleted","");
}
break;

case "report":


if(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); }
elseif(empty($POST['jobid']))
{ $json = return_json("0", "Please fill 'jobid' field");
} else {
$db->insertRow("INSERT INTO reports (user,jobid) VALUES (?,?)", array($POST['userid'], $POST['jobid']));
$json = return_json("You succesfull was reported job","");
}
break;


case "reportUser":

if(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); }
elseif(empty($POST['reported']))
{ $json = return_json("0", "Please fill 'reported' field"); 
} else {
$db->insertRow("INSERT INTO reports_user (user,reported) VALUES (?,?)", array($POST['userid'], $POST['reported']));
$json = return_json("You succesfull was report user","");
}
break;


case "deletejob":

if(empty($POST['jobid']))
{ $json = return_json("0", "Please fill 'jobid' field"); 
} else {
$db->updateRow("UPDATE jobs SET hidden = 1 WHERE id = ?", array($POST['jobid']));
$json = return_json("1","");
}
break;

case "subscribed":
if(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); 
} else {
$db->updateRow("UPDATE users SET subscribed = 1, expire = DATE_ADD(CURDATE(), INTERVAL +30 DAY) WHERE id = ?", array($POST['userid']));



$json = return_json("1","");
}
break;


case "checksubscribed":
if(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); 
} else {

//$POST['userid'] = 84;
   $user =  $db->getRow("SELECT * FROM users  WHERE id = ?", array($POST['userid']));
$v = 0;

//print_r($user);
	$expires = round((strtotime($user['expire']) - time()) / 60 / 60 / 24);




				if ($expires < 1) {
				 $v = 0;
				}else{
					$v = 1;
				}
   if($user['hidden'] == 1) {
    $error = "Your account was blocked";



    

}


$json = return_json($v,$error);
}
break;

case "addjob":

if(empty($POST['days']))
{ $json = return_json("0", "Please fill 'days' field"); }
elseif(empty($POST['title']))
{ $json = return_json("0", "Please fill 'title' field"); 
}elseif(empty($POST['lat']))
{ $json = return_json("0", "Please fill 'lat' field"); 
}elseif(empty($POST['long']))
{ $json = return_json("0", "Please fill 'long' field"); 
}elseif(empty($POST['min_price']))
{ $json = return_json("0", "Please fill 'min_price' field"); 
}elseif(empty($POST['max_price']))
{ $json = return_json("0", "Please fill 'max_price' field"); 
}elseif(strlen($POST['repeate']) == 0)
{ $json = return_json("0", "Please fill 'repeate' field"); 
}elseif(empty($POST['hours']))
{ $json = return_json("0", "Please fill 'hours' field"); 
}elseif(strlen($POST['avalabil']) == 0)
{ $json = return_json("0", "Please fill 'avalabil' field"); 
}elseif(empty($POST['informations']))
{ $json = return_json("0", "Please fill 'informations' field"); 
}elseif(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); 
}elseif(strlen($POST['private']) == 0)
{ $json = return_json("0", "Please fill 'private' field"); 
}
else {



//$POST['days'],
$days = explode(",",$POST['days']);

$place = get_location($POST['lat'], $POST['long']);
if(strlen($place['city']) > 0) {
$city = $place['city'];
} else {
    $city = "";
}

if(strlen($place['state']) > 0) {
$state = $place['state'];
} else {
    $state = "";
}

$db->insertRow("INSERT INTO jobs (title,lat,longitude,min_price, max_price, repate,hours, avalable, information, byUser,private, city, state) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)", 
array($POST['title'], $POST['lat'], $POST['long'], $POST['min_price'], $POST['max_price'],  $POST['repeate'], $POST['hours'],$POST['avalabil'], $POST['informations'], $POST['userid'], $POST['private'], $city, $state));

$job_id = $db->getRow("SELECT * FROM jobs WHERE byUser = ? ORDER by id DESC", array($POST['userid']))['id'];
$days = explode(",",$POST['days']);

$i = 1;
foreach($days as $day)
{
   

    if($day == "1")
    {
        $db->insertRow("INSERT INTO days (day, job_id) VALUES (?,?)", array($i, $job_id));
    }
     $i++;
}

$job = $db->getRow("SELECT * FROM jobs WHERE byUser = ? ORDER BY id DESC", array($POST['userid']));
$json = Job::days(array($job), true)[0];
//$json = return_json("1","");
}
break;


case "editjob":
if(empty($POST['days']))
{ $json = return_json("0", "Please fill 'days' field"); }
elseif(empty($POST['title']))
{ $json = return_json("0", "Please fill 'title' field"); 
}elseif(empty($POST['lat']))
{ $json = return_json("0", "Please fill 'lat' field"); 
}elseif(empty($POST['long']))
{ $json = return_json("0", "Please fill 'long' field"); 
}elseif(empty($POST['min_price']))
{ $json = return_json("0", "Please fill 'min_price' field"); 
}elseif(empty($POST['max_price']))
{ $json = return_json("0", "Please fill 'max_price' field"); 
}elseif(strlen($POST['repeate']) == 0)
{ $json = return_json("0", "Please fill 'repeate' field"); 
}elseif(empty($POST['hours']))
{ $json = return_json("0", "Please fill 'hours' field"); 
}elseif(strlen($POST['avalabil']) == 0)
{ $json = return_json("0", "Please fill 'avalabil' field"); 
}elseif(empty($POST['informations']))
{ $json = return_json("0", "Please fill 'informations' field"); 
}elseif(strlen($POST['userid']) == 0)
{ $json = return_json("0", "Please fill 'userid' field"); 
}elseif(empty($POST['id']))
{ $json = return_json("0", "Please fill 'id' field"); 
}else {


$db->deleteRow("DELETE FROM days WHERE job_id = ?", array($POST['id']));

$days = explode(",",$POST['days']);

$i = 1;
foreach($days as $day)
{
    

    if($day == "1")
    {
        $db->insertRow("INSERT INTO days (day, job_id) VALUES (?,?)", array($i, $POST['id']));
    }
    $i++;
}

$place = get_location($POST['lat'], $POST['long']);
if(strlen($place['city']) > 0) {
$city = $place['city'];
} else {
    $city = "";
}

if(strlen($place['state']) > 0) {
$state = $place['state'];
} else {
    $state = "";
}


$db->updateRow("UPDATE jobs  SET title= ?,lat=?,longitude=?,min_price=?, max_price=?, repate=?,hours=?, avalable=?, information=?, state = ?, city = ? WHERE id = ?", 
array($POST['title'], $POST['lat'], $POST['long'], $POST['min_price'], $POST['max_price'], $POST['repeate'], $POST['hours'], $POST['avalabil'], $POST['informations'], $state, $city, $POST['id']));
$json = return_json("1","");
}
break;

case "applications":

if(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); } else {

$finalApplication = array();
$finalApplication = array();
$jobs = $db->getRows("SELECT * FROM jobs WHERE byUser = ? and hidden = 0 ORDER by id DESC LIMIT $paginationLimit OFFSET $paginationOffset", array($POST['userid']));
$jobs = Job::days($jobs, true, $POST['userid']);
foreach($jobs as $job) {


$applications = $db->getRows("SELECT * FROM offers WHERE job_id = ? and hidden = 0", array($job['id']));

foreach($applications as $app)
{
       $object = array();
       $object['type'] = $app['type'];
$object['job'] = $job;

$object['user'] = User::profile($app['userid'], "id", $POST['userid']);

 if($app['type'] == 0) {
$object['offerType'] = "You received an offer from";
 } else {
     $object['offerType'] = "You sent an offer to";
 }

 if($app['type'] == 0 && $app['result'] == 0)
    {
        $app['result'] = 3;
    }

$object['application'] = $app;

if($app['type'] == 1) {
$finalApplication[] = $object;
} else {
   $finalApplication2[] = $object; 
}
}

}

//SORT BY ID DESC
$sortArray = array(); 

foreach($finalApplication2 as $person){ 
    foreach($person as $key=>$value){ 
        if(!isset($sortArray[$key])){ 
            $sortArray[$key] = array(); 
        } 
        $sortArray[$key][] = $value; 
    } 
} 

$orderby = "id"; //change this to whatever key you want from the array 

array_multisort($sortArray[$orderby],SORT_DESC,$finalApplication2); 


foreach($finalApplication as $final)
{
$finalApplication2[] = $final;
}


$result = $finalApplication2;
$json = return_json($result,"");
}
break;



case "applicationRemove":
if(empty($POST['application_id']))
{ $json = return_json("0", "Please fill 'application_id' field"); } else {

$db->updateRow("UPDATE offers SET hidden = 1 WHERE id = ?", array($POST['application_id']));

$json = return_json("1","");
}
break;



case "applicationAccept":

//print_r($POST);
if(empty($POST['application_id']))
{ $json = return_json("0", "Please fill 'application_id' field"); } else {

$db->updateRow("UPDATE offers SET result = 1 WHERE id = ?", array($POST['application_id']));

//$db->updateRow("UPDATE offers SET result = 1 WHERE userid  and id = ?", array($POST['userid'],$POST['application_id']));
$json = return_json("1","");
$type = $db->getRow("SELECT * FROM offers WHERE id = ?", array($POST['application_id']));
$type = $type['type'];




$jobID = Offer::getJobID($POST['application_id']);



$job = Job::jobInfo($jobID);
Push::sendOffer($POST['userid'],$job, "offer_accept", $POST['application_id'], $type);
  Mail::offer(User::profile($POST['userid'], "id"),$job, "offer_accept");
}
break;


case "applicationRefuse":
if(empty($POST['application_id']))
{ $json = return_json("0", "Please fill 'application_id' field"); } else {

$db->updateRow("UPDATE offers SET result = 2 WHERE id = ?", array($POST['application_id']));

//$db->updateRow("UPDATE offers SET result = 2 WHERE userid = ? and id = ?", array($POST['userid'],$POST['application_id']));
$json = return_json("1","");
$type = $db->getRow("SELECT * FROM offers WHERE id = ?", array($POST['application_id']));
$type = $type['type'];

$jobID = Offer::getJobID($POST['application_id']);
$job = Job::jobInfo($jobID);
Push::sendOffer($POST['userid'],$job, "offer_refuse", $POST['application_id'], $type);
Mail::offer(User::profile($POST['userid'], "id"),$job, "offer_refuse");
}
break;


case "sendJobTouser":


if(empty($POST['jobid']))
{ $json = return_json("0", "Please fill 'jobid' field"); }
elseif(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); 
}elseif(empty($POST['byUser']))
{ $json = return_json("0", "Please fill 'byUser' field"); 
}elseif(strlen($POST['invite']) == 0)
{
   $json = return_json("0", "Please fill 'invite' field"); 
} else {



$job = Job::jobInfo($POST['jobid']);



$db->insertRow("INSERT INTO offers (userid,job_id, type, fromUser) VALUES (?,?,?,?)",array($POST['userid'], $POST['jobid'], $POST['invite'], $job['byUser']));

$lastOffer = $db->getRow("SELECT * FROM offers WHERE userid = ? ORDER by id desc",array($POST['userid']));
$lastOffer = $lastOffer['id'];

if($POST['invite'] == 1) {
Push::sendOffer($POST['userid'],$job, "offer_job", $lastOffer,$POST['invite']);
Mail::offer(User::profile($POST['userid'], "id"),$job, "offer_job");
} else {
   Push::sendOffer($job['byUser'],$job, "offer_job", $lastOffer,$POST['invite']); 
   Mail::offer(User::profile($job['byUser'], "id"),$job, "offer_job");
}
 


$json = return_json("1","");
}
break;


case "myjobs":

if(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); } else {
$jobs = $db->getRows("SELECT * FROM jobs WHERE byUser = ? and hidden = 0 ORDER by id DESC LIMIT $paginationLimit OFFSET $paginationOffset", array($POST['userid']));
$jobs = Job::days($jobs, true, $POST['userid']);
$json = return_json($jobs,"");
}
break;

case "profile":
if(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); } else {
$profile = User::profile($POST['userid'], "id", $POST['myserid']);
$json = return_json($profile,"");
}
break;

// case "employess":
// $finalApplication = array();
// $jobs = $db->getRows("SELECT * FROM jobs WHERE byUser = ? and hidden = 0", array($POST['userid']));
// $jobs = Job::days($jobs);
// foreach($jobs as $job) {


// $applications = $db->getRows("SELECT * FROM offers WHERE job_id = ? and result = 1", array($POST['job_id']));

// foreach($applications as $app)
// {
//        $object = array();
// $object['job'] = $job;
// $object['application'] = $app;
// $object['user'] = User::profile($app['userid'], "id");
// $finalApplication[] = $object;
// }

// }

// $json = return_json($finalApplication,"");
// break;


case "checkCanApplyToJob":

if(empty($POST['jobid']))
{ $json = return_json("0", "Please fill 'jobid' field"); }elseif(empty($POST['user']))
{ $json = return_json("0", "Please fill 'user' field"); } else {

$job = $POST['jobid'];
$user = $POST['user'];
// print_r($POST);

$offer = $db->getRows("SELECT * FROM offers WHERE userid = ? AND job_id = ?", array($user,$job));

$response = "5";
if(count($offer)  > 0)
{
    $response  = $offer[0]['result'];
}
$json = return_json($response, "");
}
break;

case "jobsfeed":

$minprice = "";
$maxprice = "";
$near = "";
$avalability = "";


$orderBy = "ORDER BY distance ASC";

if($POST['min_price']){  $minprice = "and min_price >='$POST[min_price]'";  }

if($POST['max_price']){  
    
    if($POST['max_price'] < 100) { $maxprice = "and max_price <= $POST[max_price]"; } }



if($POST['avalability']){  $avalability = "and avalable <='$POST[avalable]'"; }

$title = "";
if($POST['skills'])
{
    $title = "AND title LIKE '%$POST[skills]%'"; 
    $orderBy = "ORDER BY distance, title ASC";
}

if($POST['nearMe'] == 1)
{
   

     $sql = "SELECT * 
        FROM (SELECT *, (((acos(sin((".$POST['lat']."*pi()/180)) *
        sin((`lat`*pi()/180))+cos((".$POST['lat']."*pi()/180)) *
        cos((`lat`*pi()/180)) * cos(((".$POST['long']."-
        `longitude`)*pi()/180))))*180/pi())*60*1.1515*1.609344) 
        as distance
        FROM `jobs`)jobs WHERE hidden =0 AND distance<=10 AND private = 0 $title $minprice $maxprice $avalability $orderBy LIMIT $paginationLimit OFFSET $paginationOffset";


} else {

     $sql = "SELECT * 
        FROM (SELECT *, (((acos(sin((".$POST['lat']."*pi()/180)) *
        sin((`lat`*pi()/180))+cos((".$POST['lat']."*pi()/180)) *
        cos((`lat`*pi()/180)) * cos(((".$POST['long']."-
        `longitude`)*pi()/180))))*180/pi())*60*1.1515*1.609344) 
        as distance
        FROM `jobs`)jobs WHERE hidden =0  AND private = 0 $title $minprice $maxprice  $avalability $orderBy LIMIT $paginationLimit OFFSET $paginationOffset";


}




$feed = $db->getRows($sql);
$feed = Job::days($feed, true, $POST['userid']);

$json = return_json($feed,"");

break;


case "nurse":

$minprice = "";
$maxprice = "";
$minyear = "";
$maxyear = "";
$near = "";
$avalable = "";
$title = "";
$orderBy = "ORDER BY distance ASC";

//search by sckills :D

if($POST['min_price']){  $minprice = "and price_min >= $POST[min_price]"; }


if($POST['max_price']){  
    
    if($POST['max_price'] < 100) { $maxprice = "and price_max <= $POST[max_price]"; } }

   

if(strlen($POST['avalability']) > 0){  $avalable = "and available_time = $POST[avalability]";

 }


if(isset($POST['max_age'])) {
if($POST['max_age'] > 0)
{
$minyear = 0;
}
if($POST['max_age'] > 1)
{
$minyear = 1;
}
if($POST['max_age'] > 4)
{
$minyear = 2;
}
if($POST['max_age'] > 6)
{
$minyear = 3;
}
if($POST['max_age'] > 9)
{
$minyear = 4;
}
if($POST['max_age'] > 14)
{
$minyear = 5;
}
if($POST['max_age'] > 19)
{
$minyear = 5;
}
$minyear = "AND experience<=$minyear";
}


if(isset($POST['min_age'])) {
if($POST['min_age'] >= 0)
{
$maxyear = 0;
}
if($POST['min_age'] > 2)
{
$maxyear = 1;
}
if($POST['min_age'] > 4)
{
$maxyear = 2;
}
if($POST['min_age'] > 6)
{
$maxyear = 3;
}
if($POST['min_age'] > 9)
{
$maxyear = 4;
}
if($POST['min_age'] > 14)
{
$maxyear = 5;
}
if($POST['min_age'] > 19)
{
$maxyear = 5;
}
$maxyear = "AND experience>=$maxyear";
}


if(strlen($POST['skills']) > 1)
{
$skills = explode(",",$POST['skills']);  

$skillList = "";
foreach($skills as $skill)
{
    $skill = trim($skill);
$rows = $db->getRows("SELECT * FROM skills WHERE name LIKE '%$skill%'");
$i = 0;
foreach($rows as $row)
{

     if(strlen($skillList) == 0)
    {
$skillList = $row['id'];
    } else {
   $skillList = $skillList.",".$row['id'];
    }
   $i++;
}
}

if(strlen($skillList) > 0) {
$users = $db->getRows("SELECT * FROM skills_attribute WHERE skill_id IN ($skillList)");
foreach($users as $row)
{

   if(strlen($skillList) == 0)
    {
$skillList = $row['user_id'];
    } else {
   $skillList = $skillList.",".$row['user_id'];
    }
   $i++;
}

 $title = "AND id IN ($skillList)";

 }  else {
   $title = "AND id IN (0)";  
}  

}    

if($POST['range'] == 1)
{
   
      $sql = "SELECT * 
        FROM (SELECT *, (((acos(sin((".$POST['lat']."*pi()/180)) *
        sin((`address_lat`*pi()/180))+cos((".$POST['lat']."*pi()/180)) *
        cos((`address_lat`*pi()/180)) * cos(((".$POST['long']."-
        `address_long`)*pi()/180))))*180/pi())*60*1.1515*1.609344) 
        as distance
        FROM `users`)users WHERE type = 1 AND available = 1 AND distance<=10 AND hidden = 0 $title $minprice $maxprice $minyear $maxyear  $avalable $orderBy LIMIT $paginationLimit OFFSET $paginationOffset";

} else {
      
    $sql = "SELECT * 
        FROM (SELECT *, (((acos(sin((".$POST['lat']."*pi()/180)) *
        sin((`address_lat`*pi()/180))+cos((".$POST['lat']."*pi()/180)) *
        cos((`address_lat`*pi()/180)) * cos(((".$POST['long']."-
        `address_long`)*pi()/180))))*180/pi())*60*1.1515*1.609344) 
        as distance
        FROM `users`)users WHERE type = 1 AND available = 1 AND hidden = 0 $title $minprice $maxprice $minyear $maxyear  $avalable $orderBy LIMIT $paginationLimit OFFSET $paginationOffset";

}

//echo $sql;


$newFeed = array();
$feed = $db->getRows($sql);
foreach($feed as $fee)
{
     

   $fee =  User::profile($fee['id'], "id", $POST['userid']);
// $fee['location'] = get_location($fee['address_lat'], $fee['address_long']);

  //   $fee['years'] = yearsDifference(date("Y-m-d"), $fee['birthday']);
   // $fee['distance'] = sprintf('%0.2f', distance($fee['address_lat'], $fee['address_long'], $POST['lat'], $POST['long'], "M"));
    //$fee['skills'] = User::skills($fee['id']);
$newFeed[] = $fee;
}
$json = return_json($newFeed,"");

break;



case "myapplications":
if(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); } else {

$finalApplication = array();

$finalApplication2 = array();

$applications = $db->getRows("SELECT * FROM offers WHERE userid = ? and hidden=0 ORDER by id desc LIMIT $paginationLimit OFFSET $paginationOffset", array($POST['userid']));

//print_r($applications);
foreach($applications as $app)
{
       $object = array();


$object['job'] = Job::jobInfo($app['job_id']);

$object['user'] = User::profile($app['userid'], "id", $POST['userid']);

 if($app['type'] == 1) {
$object['offerType'] = "You received an offer from";
 } else {
     $object['offerType'] = "You applied to a job";
 }

  if($app['type'] == 1 && $app['result'] == 0)
    {
       // echo "Result = 3";
        $app['result'] = 3;
    }

$object['application'] = $app;
if($app['type'] == 1) {

  
    $object['user'] = User::profile($app['fromUser'], "id", $POST['userid']);
$finalApplication2[] = $object;
} else {

        $object['user'] = User::profile($app['fromUser'], "id", $POST['userid']);
$finalApplication2[] = $object;

//     $object['user'] = User::profile($app['userid'], "id");
//   $finalApplication[] = $object;  
}
}

foreach($finalApplication as $final)
{
$finalApplication2[] = $final;
}

$result = $finalApplication2;

$json = return_json($result,"");
}
break;

  default:
    $json = return_json("", "404 Not found");
    break;
}




echo json_encode($json);
}

?>