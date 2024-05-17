<?php
	$mysqli = mysqli_connect('mariadb', 'cs332c24', 'UwJjjxA8' ,'cs332c24');
	if (!$mysqli) {
	die('Could not connect: ' . mysql_error());
	}
	echo 'Connected to database successfully<p>';
?>
