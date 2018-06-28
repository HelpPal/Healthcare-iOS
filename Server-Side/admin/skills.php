<?
$pageName = "Skills";
 include("top.php"); 


//Ad new level module
if(isset($_GET['add'])) {


    if(isset($_POST['submit'])) {

if(strlen($_POST['name']) > 0
) {

$db->insertRow("INSERT INTO skills (name) VALUES (?)",

array($_POST['name']));

echo "<div id='succes'>SKills was added</div>";
} else {
    echo "<div id='error'>Please complete all fields</div>";
}
    }

    $level = $db->getRow("SELECT * FROM skills WHERE id = ?", array($_GET['edit']));
?>
<form action="" method="POST">
<input type="text" name="name" placeholder="Name"/>
<input type="submit" name="submit" value="Send"/>
</form>

<?

}else if(isset($_GET['edit'])) { //Edit level

$level = $db->getRow("SELECT * FROM skills WHERE id = ?", array($_GET['edit']));
  if(isset($_POST['submit'])) {

if(strlen($_POST['name']) > 0
) {
$db->updateRow("UPDATE skills SET name = ? WHERE id =?", 
array($_POST['name'], $_GET['edit']));

echo "<div id='succes'>Skill was edited</div>";
} else {
    echo "<div id='error'>Please complete all fields</div>";
}
  }
?>

<form action="" method="POST">
<input type="text" name="name" placeholder="Name" value="<? echo $level['name']; ?>"/>

<input type="submit" name="submit" value="Send"/>
</form>

<?


}else if(isset($_GET['remove'])) { //Remove level
$db->updateRow("DELETE FROM skills_attribute WHERE skill_id = ?", array($_GET['remove']));
$db->deleteRow("DELETE FROM skills WHERE id = ?", array($_GET['remove']));

echo "<div id='succes'>Skill was deleted</div>";
//ALl levels
}else {
$rows = $db->getRows("SELECT * FROM skills ORDER by id DESC");
?>
<a class="button" href="?add">+ Add new skill</a>
<table>
<tr><td class="small">ID</td><td>Skill Name</td><td class="medium">Actions</td></tr>
<?
foreach($rows as $row)
{
    ?>
<tr><td><? echo $row['id']; ?></td><td><? echo $row['name'];?></td>
<td>
<a href="?edit=<? echo $row[id] ?>"> Edit </a>
<a href="?remove=<? echo $row[id] ?>"> Remove </a>
</td>

</tr>


    <?


} ?>

</table>

<? } ?>
