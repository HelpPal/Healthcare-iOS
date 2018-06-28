<?php
$debug = false;

 //$debug = true;


if(isset($_POST['debug'])) {
$debug = true;
}

if($debug) {
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
}

include("db.php");
include("User.php");
include("Mail.php");
include("Job.php");
include("Offer.php");
include("Push.php");
header('Content-Type: application/json');


 


class MCrypt {

    private $hex_iv = '00000000000000000000000000000000'; # converted JAVA byte code in to HEX and placed it here               
    private  $key = 'DA8B9B217DE9E';

    function __construct() {
        $this->key = hash('sha256', $this->key, true);
        //echo $this->key.'<br/>';
    }

    function encrypt($str) {       
        $td = mcrypt_module_open(MCRYPT_RIJNDAEL_128, '', MCRYPT_MODE_CBC, '');
        mcrypt_generic_init($td, $this->key, $this->hexToStr($this->hex_iv));
        $block = mcrypt_get_block_size(MCRYPT_RIJNDAEL_128, MCRYPT_MODE_CBC);
        $pad = $block - (strlen($str) % $block);
        $str .= str_repeat(chr($pad), $pad);
        $encrypted = mcrypt_generic($td, $str);
        mcrypt_generic_deinit($td);
        mcrypt_module_close($td);        
        return base64_encode($encrypted);
    }

    function decrypt($code) {        
        $td = mcrypt_module_open(MCRYPT_RIJNDAEL_128, '', MCRYPT_MODE_CBC, '');
        mcrypt_generic_init($td, $this->key, $this->hexToStr($this->hex_iv));
        $str = mdecrypt_generic($td, base64_decode($code));
        $block = mcrypt_get_block_size(MCRYPT_RIJNDAEL_128, MCRYPT_MODE_CBC);
        mcrypt_generic_deinit($td);
        mcrypt_module_close($td);        
        return $this->strippadding($str);               
    }

    /*
      For PKCS7 padding
     */

    private function addpadding($string, $blocksize = 16) {
        $len = strlen($string);
        $pad = $blocksize - ($len % $blocksize);
        $string .= str_repeat(chr($pad), $pad);
        return $string;
    }

    private function strippadding($string) {
        $slast = ord(substr($string, -1));
        $slastc = chr($slast);
        $pcheck = substr($string, -$slast);
        if (preg_match("/$slastc{" . $slast . "}/", $string)) {
            $string = substr($string, 0, strlen($string) - $slast);
            return $string;
        } else {
            return false;
        }
    }
function hexToStr($hex)
{
    $string='';
    for ($i=0; $i < strlen($hex)-1; $i+=2)
    {
        $string .= chr(hexdec($hex[$i].$hex[$i+1]));
    }
    return $string;
}
}

$encryption = new MCrypt();




function generateRandomString($length = 10) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}



function return_json($response, $error)
{
  return array("response"=>$response, "error"=>$error);
}

function remove_emoji($text){
  return preg_replace('/([0-9#][\x{20E3}])|[\x{00ae}\x{00a9}\x{203C}\x{2047}\x{2048}\x{2049}\x{3030}\x{303D}\x{2139}\x{2122}\x{3297}\x{3299}][\x{FE00}-\x{FEFF}]?|[\x{2190}-\x{21FF}][\x{FE00}-\x{FEFF}]?|[\x{2300}-\x{23FF}][\x{FE00}-\x{FEFF}]?|[\x{2460}-\x{24FF}][\x{FE00}-\x{FEFF}]?|[\x{25A0}-\x{25FF}][\x{FE00}-\x{FEFF}]?|[\x{2600}-\x{27BF}][\x{FE00}-\x{FEFF}]?|[\x{2900}-\x{297F}][\x{FE00}-\x{FEFF}]?|[\x{2B00}-\x{2BF0}][\x{FE00}-\x{FEFF}]?|[\x{1F000}-\x{1F6FF}][\x{FE00}-\x{FEFF}]?/u', '', $text);
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

// print_r($_POST['data']);





$string =  $encryption->decrypt($_POST['data']);

// echo $string;

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

 $time = 2222222222;
  if($POST['request_time'] > time()+3600 - $time)
  {
 
   $paginationLimit = 10;
    $paginationOffset = $paginationLimit*$POST['page'];



switch ($_GET['mode']) {

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



case "deletePushAndroid":
$db->updateRow("UPDATE users SET android_push = '' WHERE id = ?", array($POST['userid']));

$json = return_json("1", "");
break;

case "pusAndroid":
$db->updateRow("UPDATE users SET android_push = ? WHERE id = ?", array($POST['push'], $POST['userid']));

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
$user = $db->getRow("SELECT * FROM users WHERE email = ? and password = ?", array( strtolower($POST['username']), md5($POST['password'])));

$error = "";
if(!$user){ $error = "1";} else  {
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

$user = $db->getRow("SELECT * FROM users WHERE email = ?", array(strtolower($POST['email'])));




$error = "";
if(!$user){ $error = "1";} else { $user = "2";  Mail::sendMail($user, "recover"); }

$json = return_json($user, $error);
break;


case "check_email":
$check = $db->getRows("SELECT * FROM users WHERE  email = ?", array(strtolower($POST['email'])));


if(count($check) == 0) {
  $json = return_json("0", "0");
} else {
  $json = return_json("1", "1");
}

break;

case "register":

$check = $db->getRows("SELECT * FROM users WHERE   email = ?", array(strtolower($POST['email'])));


$other = $POST['other_skills'];
if(strlen($other) == 0)
{
$other =  "";
}

if(empty($POST['birthday']))
{
    $POST['birthday'] = "";
 //$json = return_json("0", "Please fill 'birthday' field");
}  




if(count($check) == 0) {

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

if(strlen($POST['zip']) > 0) {
    $zip = $POST['zip'];
    } else {
        $zip = "";
    }
    


   





     $desc = $POST['description'];

 if(strlen($desc) == 0)
 {
     $desc = " ";
 }
if($POST['type'] == 0)
{





   $db->insertRow("INSERT INTO users  (type,password, email, first_name, last_name,address_lat, address_long,description, city, state, address,other_skills,zip) VALUES (0,?,?,?,?,?,?,?,?,?,?,?,?)", array(md5($POST['password']), $POST['email'], $POST['first_name'], $POST['last_name'], $POST['lat'], $POST['long'],$desc,$city,$state,$addres,$other,$zip));

} else {

      $path = "media/".generateRandomString().".png";

///$mediaIMG= "http://midnight.works//appstore/health-care/$path";
 

 file_put_contents($path,base64_decode($POST['profile_img']));
 
$db->insertRow("INSERT INTO users  (type,password, email, first_name, last_name,address_lat, address_long, experience, available_time, price_min, price_max, phone, birthday, description, gender, profile_img, address,state,city, other_skills) VALUES (1,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", array(md5($POST['password']), $POST['email'], $POST['first_name'], $POST['last_name'], $POST['lat'], $POST['long'], $POST['experience'], $POST['avalable'], $POST['price_min'], $POST['price_max'], $POST['phone'],$POST['birthday'], $desc,  $POST['gender'], $path, $addres,$state,$city,$other));
$skils= explode(",", $POST['skills']);

}

$user = $db->getRow("SELECT * FROM users WHERE email = ?", array(strtolower($POST['email'])));

$db->updateRow("UPDATE users SET subscribed = 1, expire =  DATE_ADD(CURDATE(), INTERVAL +30 DAY) WHERE id = ?", array($user['id']));


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


} else {
    if($check[0]['email'] == strtolower($POST['email']))
    {
$error = "1";
    }

    //  if($check[0]['username'] == $POST['username'])
    // {
    //     $error = "2";
        
    // }
}

$user = User::profile($user['id'], "id");
  $json = return_json($user, $error);
break;

case "changepassword":
$oldpassword = $POST['oldpass'];
$newpass = $POST['newpass'];

$word = $db->getRow("SELECT * FROM users WHERE id = ?", array($POST['id']));
$currentpassword = $word['password'];
if($oldpassword == $currentpassword)
{
    $db->updateRow("UPDATE users SET password = ? WHERE id = ?", array($newpass, $POST['id']));
$response = 1;
}  else {
    $error = "Old password is wrong";
$response = 0;
}

  $json = return_json($response, $error);
break;

case "editprofile":


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

// print_r($POST);
// if($POST['type'] == 0)
// {
//     $db->updateRow("UPDATE users  SET password =?,  first_name =?, last_name=?,address_lat=?, address_long=? WHERE id = ?", array($POST['password'], $POST['first_name'], $POST['last_name'], $POST['lat'], $POST['long'], $POST['userid']));

// } else {


if(strlen($POST['zip']) > 0) {
    $zip = $POST['zip'];
    } else {
        $zip = "";
    }
    
    $other = $POST['other_skills'];
    if(strlen($other) == 0)
    {
    $other =  "";
    }

 $db->updateRow("UPDATE users  SET first_name=?, last_name=?,address_lat=?, address_long=?, experience=?, available_time=?, price_min=?, price_max=?, phone=?, birthday=?, description=?, gender=?,city = ?, address = ?, state = ?, other_skills = ?, zip = ?  WHERE id = ?", array($POST['first_name'], $POST['last_name'], $POST['lat'], $POST['long'], $POST['experience'], $POST['avalable'], $POST['price_min'], $POST['price_max'], $POST['phone'],$POST['birthday'], $POST['description'],  $POST['gender'],$city, $addres,$state,$other,$zip, $POST['userid']));
$skils= explode(",", $POST['skills']);

// }

if(strlen($POST['profile_img']) > 3) {
  $path = "media/".generateRandomString().".png";

//$mediaIMG= "http://midnight.works//appstore/health-care/$path";
 

 file_put_contents($path,base64_decode($POST['profile_img']));

$db->updateRow("UPDATE users SET profile_img = ? WHERE id = ?", array($path, $POST['userid']));
}

// if($POST['type'] != 0)
// {

$db->deleteRow("DELETE FROM skills_attribute WHERE user_id = ?", array($POST['userid']));
 foreach($skils as $skill)
{

    if($skill > 0) {
$db->insertRow("INSERT INTO skills_attribute (skill_id,user_id) VALUES (?,?)", array($skill,$POST['userid']));
    }
}

//}
$user = User::profile($POST['userid'], "id");
// $user = $db->getRow("SELECT * FROM users WHERE id = ?", array($POST['id']));
// $user['skills'] = User::skills($user);


  $json = return_json($user, $error);


break;

case "setAvalable":

$db->updateRow("UPDATE users SET available = ? WHERE id= ?", array($POST['mess'],$POST['userid']));
   $json = return_json("1", "");
break;


case "sendmessage":

$POST['text'] = remove_emoji($POST['text']);

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
break;

case "messages":
//print_r($POST);
$messages = $db->getRows("SELECT * FROM conversations WHERE user = ? ORDER by id DESC", array($POST['userid']));
$newMessages = array();

foreach($messages as $message)
{ 
    $user =  $db->getRow("SELECT * FROM users WHERE id = ?", array($message['partner']));
    $string =$user['first_name']." ".$user['last_name'];
 $message['parner-name'] = $string;

$messag1 = $db->getRow("SELECT * FROM messages WHERE (user = ? and toUser = ?) OR (toUser = ? and user = ?) ORDER by id DESC", array( $message['user'], $message['partner'],  $message['user'], $message['partner']));

$phpdate = strtotime( $messag1['time'] );
$messag1['time'] = date( 'H:i', $phpdate );

$message['last_message']  = $messag1;

$newMessages[] = $message;
}
$json = return_json($newMessages,"");
break;

case "conversation":
$conversation = $db->getRows("SELECT * FROM messages WHERE (user = ? and toUser = ?) OR (toUser = ? and user = ?)", array($POST['userid'], $POST['partnerid'], $POST['userid'], $POST['partnerid']));
$final = array();
foreach($conversation as $conversion)
{

$phpdate = strtotime( $conversion['time'] );
$conversion['time'] = date( 'H:i', $phpdate );


    $final[] = $conversion;
}

$json = return_json($final,"");
break;



case "deleteconversation":
$db->updateRow("DELETE FROM conversations WHERE (user = ? and partner = ?) OR (partner = ? and user = ?)", array($POST['userid'], $POST['conversation_id'],$POST['userid'], $POST['conversation_id']));
$db->updateRow("DELETE FROM messages  WHERE (user = ? and toUser = ?) OR (toUser = ? and user = ?)",  array($POST['userid'], $POST['conversation_id'],$POST['userid'], $POST['conversation_id']));
$json = return_json("1","");
break;

case "report":
$db->insertRow("INSERT INTO reports (user,jobid) VALUES (?,?)", array($POST['userid'], $POST['jobid']));
$json = return_json("1","");
break;


case "reportUser":
$db->insertRow("INSERT INTO reports_user (user,reported) VALUES (?,?)", array($POST['userid'], $POST['reported']));
$json = return_json("1","");
break;


case "deletejob":
$db->updateRow("UPDATE jobs SET hidden = 1 WHERE id = ?", array($POST['jobid']));
$json = return_json("1","");
break;


case "subscribed":
if(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); 
} else {
$db->updateRow("UPDATE users SET subscribed = 1, expire =  DATE_ADD(CURDATE(), INTERVAL +30 DAY) WHERE id = ?", array($POST['userid']));
$json = return_json("1","");
}
break;


case "checksubscribed":
if(empty($POST['userid']))
{ $json = return_json("0", "Please fill 'userid' field"); 
} else {
   $user =  $db->getRow("SELECT * FROM users  WHERE id = ?", array($POST['userid']));

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


//$POST['days'],
$days = explode(",",$POST['days']);
$private = $_POST['private'];
if(!$private)
{
    $private = 0;
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


$db->insertRow("INSERT INTO jobs (title,lat,longitude,min_price, max_price, repate,hours, avalable, information, byUser,private,city, state) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)", 
array($POST['title'], $POST['lat'], $POST['long'], $POST['min_price'], $POST['max_price'],  $POST['repeate'], $POST['hours'],$POST['avalabil'], $POST['informations'], $POST['userid'], $private,$city, $state));

$job_id = $db->getRow("SELECT * FROM jobs WHERE byUser = ? ORDER by id DESC", array($POST['userid']))['id'];
$days = explode(",",$POST['days']);

$i = 0;
foreach($days as $day)
{
    $i++;

    if($day == "1")
    {
        $db->insertRow("INSERT INTO days (day, job_id) VALUES (?,?)", array($i, $job_id));
    }
    
}

$job = $db->getRow("SELECT * FROM jobs WHERE byUser = ? AND hidden = 0 ORDER BY id DESC", array($POST['userid']));
$json = Job::days(array($job))[0];
//$json = return_json("1","");

break;


case "editjob":

$db->deleteRow("DELETE FROM days WHERE job_id = ?", array($POST['id']));

$days = explode(",",$POST['days']);

$i = 0;
foreach($days as $day)
{
    $i++;

    if($day == "1")
    {
        $db->insertRow("INSERT INTO days (day, job_id) VALUES (?,?)", array($i, $POST['id']));
    }
    
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
array($POST['title'], $POST['lat'], $POST['long'], $POST['min_prie'], $POST['max_prie'], $POST['repeate'], $POST['hours'], $POST['avalabil'], $POST['informations'],$city, $state, $POST['id']));
$json = return_json("1","");

break;

case "applications":
$finalApplication = array();
$finalApplication = array();
$jobs = $db->getRows("SELECT * FROM jobs WHERE byUser = ? and hidden = 0 ORDER by id DESC LIMIT $paginationLimit OFFSET $paginationOffset", array($POST['userid']));
$jobs = Job::days($jobs, false,$POST['userid']);
foreach($jobs as $job) {


$applications = $db->getRows("SELECT * FROM offers WHERE job_id = ? and hidden = 0", array($job['id']));

foreach($applications as $app)
{
       $object = array();
       $object['type'] = $app['type'];
$object['job'] = $job;
$object['application'] = $app;
$object['user'] = User::profile($app['userid'], "id", $POST['userid']);

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
break;



case "applicationRemove":


$db->updateRow("UPDATE offers SET hidden = 1 WHERE id = ?", array($POST['application_id']));

$json = return_json("1","");

break;



case "applicationAccept":

//print_r($POST);

$db->updateRow("UPDATE offers SET result = 1 WHERE id = ?", array($POST['application_id']));

//$db->updateRow("UPDATE offers SET result = 1 WHERE userid  and id = ?", array($POST['userid'],$POST['application_id']));
$json = return_json("1","");
$type = $db->getRow("SELECT * FROM offers WHERE id = ?", array($POST['application_id']));
$type = $type['type'];




$jobID = Offer::getJobID($POST['application_id']);



$job = Job::jobInfo($jobID);
Push::sendOffer($POST['userid'],$job, "offer_accept", $POST['application_id'], $type);
  Mail::offer(User::profile($POST['userid'], "id"),$job, "offer_accept");
break;


case "applicationRefuse":
$db->updateRow("UPDATE offers SET result = 2 WHERE id = ?", array($POST['application_id']));

//$db->updateRow("UPDATE offers SET result = 2 WHERE userid = ? and id = ?", array($POST['userid'],$POST['application_id']));
$json = return_json("1","");
$type = $db->getRow("SELECT * FROM offers WHERE id = ?", array($POST['application_id']));
$type = $type['type'];

$jobID = Offer::getJobID($POST['application_id']);
$job = Job::jobInfo($jobID);
Push::sendOffer($POST['userid'],$job, "offer_refuse", $POST['application_id'], $type);
Mail::offer(User::profile($POST['userid'], "id"),$job, "offer_refuse");
break;


case "sendJobTouser":
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
break;


case "myjobs":
$jobs = $db->getRows("SELECT * FROM jobs WHERE byUser = ? and hidden = 0 ORDER by id DESC LIMIT $paginationLimit OFFSET $paginationOffset", array($POST['userid']));
$jobs = Job::days($jobs, false, $POST['userid']);
$json = return_json($jobs,"");
break;

case "profile":
$profile = User::profile($POST['userid'], "id", $POST['myuserid']);
$json = return_json($profile,"");
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
$job = $POST['jobid'];
$user = $POST['user'];
// print_r($POST);

$offer = $db->getRows("SELECT * FROM offers WHERE userid = ? AND job_id = ?", array($user,$job));

$response = "5";
if(count($offer)  > 0)
{
    $response  = $offer[0]['result'];
}


  if( $offer[0]['invite'] == 1 &&  $offer[0]['result'] == 0)
    {
       $response = 3;
    }

$json = return_json($response, $offer[0]['id']);

break;

case "jobsfeed":
 
//  $POST['skills'] = "Test";
//  $POST['range'] = "0";


$minprice = "";
$maxprice = "";
$minyear = "";
$maxyear = "";
$near = "";
$avalability = "";

$orderBy = "ORDER BY distance ASC";

if($POST['min_price']){  $minprice = "and min_price >='$POST[min_price]'";  }
if($POST['max_price']){  $maxprice = "and max_price <='$POST[max_price]'"; }


if($POST['avalability']){  $avalability = "and avalable <='$POST[avalability]'"; }


$title = "";
if($POST['skills'])
{
    $title = "AND title LIKE '%$POST[skills]%'"; 
    $orderBy = "ORDER BY distance, title ASC";
}

if($POST['range'] == 1)
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
        FROM `jobs`)jobs WHERE hidden =0  AND private = 0 $title $minprice $maxprice $avalability $orderBy LIMIT $paginationLimit OFFSET $paginationOffset";


}

//echo $sql; 



$feed = $db->getRows($sql);
$feed = Job::days($feed, false, $POST['userid']);

$json = return_json($feed,"");

break;


case "nurse":

// $POST['skills'] = "Cancer, Drive";
//     $POST['range'] = "0";
// print_r($POST);


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
if($POST['max_price']){  $maxprice = "and price_max <= $POST[max_price]"; }
if($POST['avalability']){  $avalable = "and available_time = $POST[avalability]"; }

if(isset($POST['max_age'])) {
if($POST['max_age'] > 0)
{
$minyear = 0;
}
if($POST['max_age'] > 2)
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

// if($POST['min_year']){  $minyear = "and min_year >='$POST[min_year]'"; }
// if($POST['max_year']){  $maxyear = "and max_year <='$POST[max_year]'"; }
//SEarch by experience :D
//if($POST['min_year']){  $minyear = "and experience = $POST[min_year]"; }

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
        FROM `users`)users WHERE type = 1 AND available = 1 AND distance<=10 AND hidden = 0 $title $minprice $maxprice $minyear $maxyear $avalable $orderBy LIMIT $paginationLimit OFFSET $paginationOffset";

} else {
      
    $sql = "SELECT * 
        FROM (SELECT *, (((acos(sin((".$POST['lat']."*pi()/180)) *
        sin((`address_lat`*pi()/180))+cos((".$POST['lat']."*pi()/180)) *
        cos((`address_lat`*pi()/180)) * cos(((".$POST['long']."-
        `address_long`)*pi()/180))))*180/pi())*60*1.1515*1.609344) 
        as distance
        FROM `users`)users WHERE type = 1 AND available = 1  AND hidden = 0 $title $minprice $maxprice $minyear $maxyear $avalable $orderBy LIMIT $paginationLimit OFFSET $paginationOffset";

}

// echo $sql;
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

$finalApplication = array();

$finalApplication2 = array();

$applications = $db->getRows("SELECT * FROM offers WHERE userid = ? and hidden=0 ORDER by id desc LIMIT $paginationLimit OFFSET $paginationOffset", array($POST['userid']));

//print_r($applications);
foreach($applications as $app)
{
       $object = array();


$object['job'] = Job::jobInfo($app['job_id']);
$object['application'] = $app;
$object['user'] = User::profile($app['userid'], "id", $POST['userid']);
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
break;

  default:
    $json = return_json("", "404 Not found");
    break;
}



#Functions

  } else {
    $json = return_json("","Request timeout");
  }

echo json_encode($json);
}












