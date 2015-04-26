<?php

	include 'connect.php';

	$sql = "UPDATE categories 
			SET catEnd = '0 99:0:0.000000'
			WHERE categoryID = '" . mysql_real_escape_string($_POST['categoryID']) . "'";

	$result = mysql_query($sql);

	if ($result) {
    	echo ('Job accepted');
	}else{
    	echo ('Failed to accept job');
	}

?>
