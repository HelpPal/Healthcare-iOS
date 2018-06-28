<?
include("../db.php");
if(!$db->isConnected) {
echo "Please perform check Db Connection script";
exit;
} else {
session_start(); // Starting Session
$error=''; // Variable To Store Error Message
if (isset($_POST['submit'])) {
if (empty($_POST['username']) || empty($_POST['password'])) {
$error = "Username or Password is invalid";
}
else
{
// Define $username and $password
$username=$_POST['username'];
$password=$_POST['password'];

if ($username == 'admin' && $password == 'demo1235') {
$_SESSION['login_user']=$username; // Initializing Session
header("location: index.php"); // Redirecting To Other Page
} else {
$error = "Username or Password is invalid";
}

}
}

?>
<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>

<div id="main">
	<div id="login">
		<div class="logotype"></div>
		<div class="error">
			<span><?php echo $error; ?></span>
		</div>
		<form action="" method="post">
		<div>	
			<label id="login"></label>
			<input id="name" name="username" type="text">
		</div>
		<div>	
			<label id="pass"></label>
			<input id="password" name="password" type="password">
		</div>
		<input name="submit" type="submit" value=" Login ">

		</form>
	</div>
</div>
</body>
</html>
<?php } ?>