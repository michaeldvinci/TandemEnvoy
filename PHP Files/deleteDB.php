<?php

	include 'connect.php';

	$sql = "DELETE FROM categories WHERE categoryID = '" . mysql_real_escape_string($_POST['categoryID']) . "'";

	$result = mysql_query($sql);

	if ($result) {
    	echo ('Paid For!');
	}else{
    	echo ('didnt finish order');
	}

?>
