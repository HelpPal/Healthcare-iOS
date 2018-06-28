<?
$pageName = "Users";
include("top.php"); 
include("../User.php");

if(isset($_GET['extend']))
{

$db->updateRow("UPDATE users SET subscribed = 1, expire =  DATE_ADD(CURDATE(), INTERVAL +30 DAY)  WHERE id = $_GET[extend]");

}elseif(isset($_GET['remove'])) { //Remove level
$db->updateRow("UPDATE users SET hidden = 1 WHERE id = ?", array($_GET['remove']));

echo "<div id='succes'>User was blocked</div>";
if ($_GET['type'] == "indi") {
	header("Location: users.php?type=individuals");	
}else {	
	header("Location: users.php");
}
//ALl levels
}elseif(isset($_GET['unremove'])) { //Remove level
$db->updateRow("UPDATE users SET hidden = 0 WHERE id = ?", array($_GET['unremove']));

echo "<div id='succes'>User was unblocked</div>";
if ($_GET['type'] == "indi") {
	header("Location: users.php?type=individuals");	
}else {	
	header("Location: users.php");
}
//ALl levels
}else {


$id = "";
if(isset($_GET['id'])) {
	$getID = $_GET['id'];
	$type = $db->getRows("SELECT type FROM users WHERE id = $getID");
	$typeID = $type[0]['type'];

	// If user is Individual we redirect him to individuals table
	if ($typeID == 0 && $_GET['type'] != "individuals") {
		header("Location: users.php?type=individuals&id=".$getID);	
	}

	// If user is CNA we redirect him to CNA table
	if ($typeID == 1 && $_GET['type'] == "individuals") {
		header("Location: users.php?type=cna&id=".$getID);
	}

	// Search filter
	$id = "AND id = $_GET[id]";
}


if ($_GET['type'] == "individuals") {
	$rows = $db->getRows("SELECT * FROM users WHERE type = '0' $id ORDER by id DESC ");
}else {
	$rows = $db->getRows("SELECT * FROM users WHERE type = '1' $id ORDER by id DESC");
}

?>




<?php if ($_GET['type'] == "individuals") { ?>	
	<h3><a href='users.php?type=cna'>CNA Professionals</a> | Individuals</h3>
	<table>
		<tr>
			<td>ID</td>
			<td>Email</td>
			<td>Name</td>
			<td>Location</td>
			<td>Subscription</td>
			<td class="small">Jobs</td>
			<td class="small">Private</td>
			<td class="small">Actions</td>
		</tr>
		<?php foreach ($rows as $row) { ?>
		<tr <?php if ($row['hidden'] == 1) { echo "class='blocked'"; } ?>>
			<td><? echo $row['id'];?></td>


			<!-- Email -->
			<td><? echo $row['email'];?></td>			


			<!-- Name -->
			<td><? echo $row['first_name']." <BR>".$row['last_name'];?></td>


			<!-- Location -->
			<td>
				<a target="_blank" href="https://www.google.com/maps?q=<? echo $row['address_lat'];?>,<? echo $row['address_long'];?>">
					<?php echo User::profile($row['id'], "id")["location"]['state'] . ", " . User::profile($row['id'], "id")["location"]['city']; ?>	
				</a>
			</td>


			<!-- Subscription -->
			<td title="<?php echo $row['expire']; ?>">                    
				<? 
				$expires = round((strtotime($row['expire']) - time()) / 60 / 60 / 24);
				if ($expires < 1) {
					echo "<span style='color:red;'>Expired</span> <a href='http://104.131.152.91/health-care/admin/users.php?extend=" . $row['id'] . "'>(+)</a>";
				}else{
					echo $expires . " days left <a href='http://104.131.152.91/health-care/admin/users.php?extend=" . $row['id'] . "'>(+)</a>";
				}
				?>  
			</td>



			<!-- Jobs -->
			<td>				
				<?php 

				$jobs = $db->getRows("SELECT * FROM jobs WHERE byUser = $row[id]");
				echo count($jobs);

				?>
			</td>



			<!-- Private jobs -->
			<td>				
			<?php 
				$private_jobs = $db->getRows("SELECT * FROM jobs WHERE byUser = $row[id] AND private = 1");
				echo count($private_jobs);
				?>				
			</td>





			<!-- Actions -->
			<td>
				<?php if ($row['hidden'] == 1) { ?>
					<a href="?unremove=<? echo $row[id] ?>&type=indi"> Unblock </a>
				<?php }else { ?>
					<a href="?remove=<? echo $row[id] ?>&type=indi"> Block </a>
				<?php } ?>
			</td>
		</tr>
		<?php } ?>
	</table>

<?php } else { ?>

	<h3>CNA Professionals | <a href='users.php?type=individuals'>Individuals</a></h3>
	<table>
		<tr>
			<td>ID</td>
			<td>Registered</td>
			<td>Profile pic</td>
			<td>Name</td>
			<td>Description</td>
			<td>Email</td>
			<td>Subscription</td>
			<td>Experience</td>
			<td>Price</td>
			<td>Skills</td>
			<td>Location</td>
			<td>Availability</td>
			<td>Phone</td>
			<td>Gender</td>
			<td>Actions</td>
		</tr>
		<?php foreach($rows as $row) { ?>
		<tr <?php if ($row['hidden'] == 1) { echo "class='blocked'"; } ?>>
	

			<!-- ID -->
			<td><? echo $row['id']; ?></td>


			<!-- Registered -->
			<td title="<?php echo $row['registration_time']; ?>"><?php echo round((time() - strtotime($row['registration_time'])) / 60 / 60 / 24) . " days ago"; ?></td>


			<!-- Profile picture -->
			<td><a target="_blank" href="http://104.131.152.91/health-care/<? echo $row['profile_img'];?>"><div class="user_avatar" style="background-image:url('http://104.131.152.91/health-care/<? echo $row['profile_img'];?>');"></div></a></td>
			

			<!-- Name -->
			<td><? echo $row['first_name']." <BR>".$row['last_name'];?></td>


			<!-- Description -->
			<td><?php echo $row['description'] ?></td>
				

			<!-- Email -->
			<td><? echo $row['email'];?></td>
			<td title="<?php echo $row['expire']; ?>">                    
				<? 
				$expires = round((strtotime($row['expire']) - time()) / 60 / 60 / 24);
				if ($expires < 1) {
					echo "<span style='color:red;'>Expired</span> <a href='http://104.131.152.91/health-care/admin/users.php?extend=" . $row['id'] . "'>(+)</a>";
				}else{
					echo $expires . " days left <a href='http://104.131.152.91/health-care/admin/users.php?extend=" . $row['id'] . "'>(+)</a>";
				}
				?>  
			</td>


			<!-- Experience -->
			<td>
				<?php
					$experience = $row['experience'];
					if($experience == 0) { $experience = "Less than 1 year"; }
					if($experience == 1) { $experience = "2-4 years"; }
					if($experience == 2) { $experience = "5-9 years"; }
					if($experience == 3) { $experience = "10-14 years"; }
					if($experience == 4) { $experience = "15-20 years"; }
					if($experience == 5) { $experience = "20+ years"; }
					echo $experience;
				?>
			</td>


			<!-- Price -->
			<td><? echo "$" . $row['price_min']." - $".$row['price_max'];?></td>
			

			<!-- Skills -->
			<td>				
				<?php
				$skillList = User::profile($row['id'], "id")['skills'];
				foreach ($skillList as $skill) {
					echo "<span class='skill'>" . $skill['name'] . "</span>";
				}
				?>
			</td>


			<!-- Location -->
			<td>
				<a target="_blank" href="https://www.google.com/maps?q=<? echo $row['address_lat'];?>,<? echo $row['address_long'];?>">
					<?php echo User::profile($row['id'], "id")["location"]['state'] . ", " . User::profile($row['id'], "id")["location"]['city']; ?>	
				</a>
			</td>


			<!-- Availability -->
			<td><? if ($row['available_time'] == 1) { echo "Full time"; } else { echo "Part time"; } ?></td>


			<!-- Phone -->
			<td><? echo $row['phone'];?></td>

			
			<!-- Gender -->
			<td>
				<? 	$gender = $row['gender'];
				if ($gender == 0) {
					$gender = "Male";
				} else {
					$gender = "Female";
				}
				echo $gender; ?>
			</td>


			<!-- Actions -->
			<td>
				<?php if ($row['hidden'] == 1) { ?>
					<a href="?unremove=<? echo $row[id] ?>"> Unblock </a>
				<?php }else { ?>
					<a href="?remove=<? echo $row[id] ?>"> Block </a>
				<?php } ?>
			</td>
		</tr>
		<?php } ?>
	</table>
<?php } ?>
<? } ?>
