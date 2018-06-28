<?
// error_reporting(E_ALL);
// ini_set('display_errors', 1);
$pageName = "Jobs";
include("top.php"); 
include("../Job.php");

if(isset($_GET['remove'])) { //Remove level
	$db->updateRow("UPDATE jobs SET hidden = 1 WHERE id = ?", array($_GET['remove']));
	echo "<div id='succes'>Job was deleted</div>";
	header("Location: jobs.php");
}elseif (isset($_GET['unremove'])) {
	$db->updateRow("UPDATE jobs SET hidden = 0 WHERE id = ?", array($_GET['unremove']));
	echo "<div id='succes'>Job was unblocked</div>";
	header("Location: jobs.php");
//ALl levels
}else {
	$id = "";
	if(isset($_GET['id'])) {
		$id = "WHERE id=$_GET[id]";
	}
	$rows = $db->getRows("SELECT * FROM jobs $id ORDER by id DESC"); ?>

	<table>
		<tr>
			<td>ID</td>
			<td>Job Name</td>
			<td>Location</td>
			<td>Availability</td>
			<td>Price</td>
			<td>Author</td>
			<td>Job description</td>
			<td>Created</td>
			<td>Private</td>
			<td>Blocked</td>
			<td>Actions</td>
		</tr>

		<?php foreach($rows as $row) { ?>
		<tr <?php if ($row['hidden'] == 1) { echo "class='blocked'"; } ?>>
			<td><? echo $row['id']; ?></td>
			<td><? echo $row['title'];?></td>
			<td>
				<a target="_blank" href="https://www.google.com/maps?q=<? echo $row['address_lat'];?>,<? echo $row['address_long'];?>">
					<?php echo Job::jobInfo($row['id'])['location']['state'] . ", " . Job::jobInfo($row['id'])['location']['city']; ?>
				</a>
			</td>
			<td><?php
				if ($row['avalable'] == 0) { 
					echo "<BR>Full time"; 
				}else { 
					echo "Part time"; 
					echo "<BR>" . $row['hours'] . "h / day";
				}

				if ($row['repate'] == 1) {
					echo "<BR> Repeatedly";
				}else {
					echo "<BR> One time";
				}
				?>					
			</td>
			<td><?php echo "$" . $row['min_price']."-$".$row['max_price']; ?></td>

			<td><a href="users.php?id=<? echo $row['byUser'];?>"><? echo $row['byUser'];?></a></td>
			<td><? echo $row['information'];?></td>
			<td><?php echo round((time() - strtotime($row['date'])) / 60 / 60 / 24) . " days ago"; ?></td>
			<td><?php if ($row['private'] == 0) { echo "-"; }else { echo "Private"; } ?></td>
			<td><? echo $row['hidden'];?></td>
			<td>
			<?php if ($row['hidden'] == 0) { ?>
				<a href="?remove=<? echo $row[id] ?>"> Block </a>
			<?php }else{ ?>
				<a href="?unremove=<? echo $row[id] ?>"> Unblock </a>
			<?php } ?>
			</td>
		</tr>
	<? } ?>
	</table>
<? } ?>
