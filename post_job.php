cat post_job.php                              /var/www/traviscj.com/job_queue

<?php print_r($_POST); ?>
<?php 
#connect to database
$DBHOST="localhost";
$DBUSER="job_queue";
$DBPASS="somepassword";
$DBNAME="job_queue";
$conn = mysql_connect($DBHOST,$DBUSER,$DBPASS) or die('could not connect');
mysql_select_db($DBNAME);

# write to data file specified in database..
$jobKey = $_POST["key"];
$job_sql = "SELECT * FROM `queue` WHERE `jobKey`='$jobKey';";
$job_result = mysql_query($job_sql) or die('could not query...');
$job_row = mysql_fetch_assoc($job_result) or die('no matches...');
$myFile = $job_row['outputFile'];
$fh = fopen($myFile, 'w');
fwrite($fh, $_POST["stat"]);
fclose($fh);

# move status from pending to finished
$job_index = $job_row['index'];
$statusUpdate_sql = "UPDATE `job_queue`.`queue` SET `status` = 'D' WHERE `queue`.`index` =$job_index LIMIT 1 ;";
$statusUpdate_result = mysql_query($statusUpdate_sql) or die('could not update job status');
?>

