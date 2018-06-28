<?
$pageName = "Reports";
 include("top.php"); 

if(isset($_GET['remove_user'])) { //Remove user

	$db->updateRow("UPDATE users SET hidden = 1 WHERE id = ?", array($_GET['remove_user']));
	$db->updateRow("UPDATE reports_user SET resolved = 1 WHERE reported = ?", array($_GET['remove_user']));
	echo "<div id='succes'>User was blocked</div>";
	
}elseif(isset($_GET['remove_job'])) { //Remove job

	$db->updateRow("UPDATE jobs SET hidden = 1 WHERE id = ?", array($_GET['remove_job']));
	$db->updateRow("UPDATE reports SET resolved = 1 WHERE jobid = ?", array($_GET['remove_job']));
	echo "<div id='succes'>Job was deleted</div>";

}elseif(isset($_GET['clear_job'])) { //Clear job report

	$db->updateRow("UPDATE reports SET resolved = 1 WHERE jobid = ?", array($_GET['clear_job']));
	echo "<div id='succes'>Report Was Clear</div>";
	header ("Location: reports.php?type=jobs");

}elseif(isset($_GET['clear_user'])) { //Clear user report

	$db->updateRow("UPDATE reports_user SET resolved = 1 WHERE reported = ?", array($_GET['clear_user']));
	echo "<div id='succes'>Report Was Clear</div>";
	header ("Location: reports.php");

}else {

	if ($_GET['type'] == "jobs") { ?>
		<h3><a href='reports.php'>Users</a> | Jobs</h3>
		<table>
			<tr>
				<td>Job name</td>
				<td>Private</td>
				<td class="medium">Reported by</td>
				<td class="medium">Reported</td>
				<td class="medium">Actions</td>
			</tr>
			<?php 
				$rows = $db->getRows("SELECT * FROM reports WHERE resolved = 0 ORDER by date DESC");
				foreach($rows as $report) { 
				    $row = $db->getRow("SELECT * FROM jobs WHERE id =?",array($report['jobid']));
				    $rowUsers = $db->getRow("SELECT * FROM users WHERE id =?",array($row['id']));
					?>
					<tr>
						<td><a href="jobs.php?id=<?php echo $row['id']; ?>"><?php echo $row['title']; ?></a></td>
						<td><?php if ($row['private'] == 1) { echo "Private"; }else { echo "Public"; } ?></td>
						<td><a href="users.php?id=<?php echo $row['id'] ?>"><?php echo $rowUsers['first_name'] . " " . $rowUsers['last_name']; ?></a></td>
						<td><?php echo round((time() - strtotime($row['date'])) / 60 / 60 / 24) . " days ago"; ?></td>
						<td><a href="?clear_job=<?php echo $row[id]; ?>">Mark as resolved</a></td>
					</tr>
			<?php } ?>

			<?php 
				$rows = $db->getRows("SELECT * FROM reports WHERE resolved = 1 ORDER by date DESC");
				foreach($rows as $report) { 
				    $row = $db->getRow("SELECT * FROM jobs WHERE id =?",array($report['jobid']));
				    $rowUsers = $db->getRow("SELECT * FROM users WHERE id =?",array($row['id']));
					?>
					<tr class="resolved">
						<td><a href="<?php echo $row['id']; ?>"><?php echo $row['title']; ?></a></td>
						<td><?php if ($row['private'] == 1) { echo "Private"; }else { echo "Public"; } ?></td>
						<td><a href="users.php?id=<?php echo $row['id'] ?>"><?php echo $rowUsers['first_name'] . " " . $rowUsers['last_name']; ?></a></td>
						<td><?php echo round((time() - strtotime($row['date'])) / 60 / 60 / 24) . " days ago"; ?></td>
						<td>Resolved</td>
					</tr>
			<?php } ?>		
		</table>

	<?php }else{ ?>

		<h3>Users | <a href='reports.php?type=jobs'>Jobs</a></h3>
		<table>
			<tr>
				<td>Person name</td>
				<td>Type</td>
				<td class="medium">Reported by</td>
				<td class="medium">Reported</td>
				<td class="medium">Actions</td>
			</tr>
			<?php $rows = $db->getRows("SELECT * FROM reports_user WHERE resolved = 0 ORDER by date DESC"); ?>
			<?php foreach ($rows as $report) { ?>
				<?php $row = $db->getRow("SELECT * FROM users WHERE id =?", array($report['reported'])); ?>
				<tr>
					<td><a href="users.php?id=<?php echo $row['id']; ?>"><?php echo $row['first_name'] . " " . $row['last_name']; ?></a></td>
					<td><?php if ($row['type'] == 0) { echo "Individual"; }else{ echo "CNA"; } ?></td>
					<td>
						<a href="users.php?id=<? echo $report['user'];?>">
							<?php $reporter_id = $report['user']; ?>
							<?php $reporter = $db->getRow("SELECT first_name, last_name FROM users WHERE id = $reporter_id"); ?>
							<?php echo $reporter['first_name'] . " " . $reporter['last_name']; ?>						
						</a>
					</td>
					<td>
						<?php echo round((time() - strtotime($report['date'])) / 60 / 60 / 24) . " days ago"; ?>					
					</td>
					<td><a href="?clear_user=<?php echo $row[id]; ?>">Mark as resolved</a></td>
				</tr>
			<?php } ?>
			<?php $rows = $db->getRows("SELECT * FROM reports_user WHERE resolved = 1 ORDER by date DESC"); ?>
			<?php foreach ($rows as $report) { ?>
				<?php $row = $db->getRow("SELECT * FROM users WHERE id =?", array($report['reported'])); ?>
				<tr class="resolved">
					<td><a href="users.php?id=<?php echo $row['id']; ?>"><?php echo $row['first_name'] . " " . $row['last_name']; ?></a></td>
					<td><?php if ($row['type'] == 0) { echo "Individual"; }else{ echo "CNA"; } ?></td>
					<td>
						<a href="users.php?id=<? echo $report['user'];?>">
							<?php $reporter_id = $report['user']; ?>
							<?php $reporter = $db->getRow("SELECT first_name, last_name FROM users WHERE id = $reporter_id"); ?>
							<?php echo $reporter['first_name'] . " " . $reporter['last_name']; ?>						
						</a>
					</td>
					<td>
						<?php echo round((time() - strtotime($report['date'])) / 60 / 60 / 24) . " days ago"; ?>					
					</td>
					<td>Resolved</td>
				</tr>
			<?php } ?>
		</table>
	<?php } ?>
<?php } ?>