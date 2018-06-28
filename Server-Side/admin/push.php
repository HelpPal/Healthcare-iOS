<?
$pageName = "Pushes";
 include("top.php"); 
 include("../Push.php");



    if(isset($_POST['submit'])) {

if(strlen($_POST['name']) > 0 
) {

$users = $db->getRows("SELECT * FROM users WHERE android_push <> '' OR ios_push <> ''");


foreach($users as $user)
{

    $text = $_POST['name'];

    Push::adminPush($user, $text);
}

echo "<div id='succes'>Push  was added</div>";
} else {
    echo "<div id='error'>Please complete all fields</div>";
}
    }

  
?>
<form action="" method="POST">
<input type="text" name="name" placeholder="Text" />






<input type="submit" name="submit" value="Send"/>
</form>

<?



