
<?
$pageName = "Main";
 include("top.php");


// Get all reports count
$reported_users = $db->getRows("SELECT * FROM reports_user WHERE resolved = 0 ORDER by id DESC, resolved DESC");
$reported_jobs = $db->getRows("SELECT * FROM reports WHERE resolved = 0 ORDER by id DESC, resolved DESC");
$reports = count($reported_users) + count($reported_jobs);


//Getting New users for today
$new_users = $db->getRows("SELECT registration_time FROM users WHERE UNIX_TIMESTAMP(registration_time) > UNIX_TIMESTAMP(NOW())-86400");
$new_users = count($new_users);


// Getting New jobs for today
$new_jobs = $db->getRows("SELECT date FROM jobs WHERE UNIX_TIMESTAMP(date) > UNIX_TIMESTAMP(NOW())-86400");
$new_jobs = count($new_jobs);
?>


<div class="statistics">
	<div class="statistic" title="This includes both reported jobs and reported users">
		<div class="counter"><?php echo $reports; ?></div>
		<div class="title">Unresolved reports</div>
	</div>

	<div class="statistic" title="Calculating all users for the last 24 hours">
		<div class="counter"><?php echo $new_users; ?></div>
		<div class="title">New users today</div>
	</div>

	<div class="statistic" title="Calculating all jobs for the last 24 hours">
		<div class="counter"><?php echo $new_jobs; ?></div>
		<div class="title">New jobs today</div>
	</div>
</div>
