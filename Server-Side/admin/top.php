<?php 

session_start();
$user_check=$_SESSION['login_user'];

if(!isset($user_check)){
header('Location: login.php'); 
exit;
}
 
include("../db.php"); 




?>
<html>
<head>
	<title>CNA - Health Care Connector - Dashboard</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>

<div class="header">
	<div class="logotype"></div>
	<div class="menu">
		<a href="index.php">Main</a>
		<a href="jobs.php">Jobs</a>
		<a href="users.php">Users</a>
		<a href="skills.php">Skills</a>
		<a href="reports.php">Reports</a>
		<a href="push.php">Push notifications</a>
		<a href="logout.php">Logout</a>
	</div>
	
</div>
<h1><? echo $pageName; ?></h1> <br/>

