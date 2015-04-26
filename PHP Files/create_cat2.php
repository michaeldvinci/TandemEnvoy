<?php

	include 'connect.php';

	$endTime = $_POST['catEnd'];

	$days = (((int)$endTime)/60)/24;
	echo $days;

	$minutes = (((int)$endTime)%60);
	$startD = "'0 3:";
	$endD = ":0.000000'";
	$catEnd = $startD . $endTime . $endD;

	echo $catEnd;

	$sql = "INSERT INTO categories(categoryName, categoryDesc, categoryUser, catStart, catEnd)
	   VALUES('" . mysql_real_escape_string($_POST['categoryName']) . "',
			 '" . mysql_real_escape_string($_POST['categoryDesc']) . "',
			 '" . mysql_real_escape_string($_POST['categoryUser']) . "',
            ADDTIME(CURRENT_TIME(), '0 3:0:0.000000'),
            ADDTIME(CURRENT_TIME(), $catEnd))";

	$result = mysql_query($sql);
	if(!$result)
	{
		echo 'Error' . mysql_error();
	}
	else
	{
		echo 'New category succesfully added.';
	}

?>
