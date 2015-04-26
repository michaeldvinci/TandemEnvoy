<?php

//create_cat.php
include 'connect.php';
include 'header.php';

echo '<h2>Create a category</h2>';

//the user has admin rights
	if($_SERVER['REQUEST_METHOD'] != 'POST')
	{
		//the form hasn't been posted yet, display it
		echo '<form method="post" action="">
			Category name: <input type="text" name="categoryName" /><br />
			Category description:<br /> <textarea name="categoryDesc" /></textarea><br />
			Job Duration [mins]: <input type="text" name="catEnd" /><br /><br />
			<input type="submit" value="Add category" />
		 </form>';
	}
	else
	{
		$endTime = $_POST['catEnd'];
		$minutes = $endTime;
		  $hours = 3;
		$endTime = (int)$endTime;

		if ($endTime > 59) {
			  $hours = 3 + ($endTime/60);
			$minutes = ($endTime % 60) * 60;
		}

		 $startD = "'0 ";
		  $colon = ":";
		   $endD = ":0.000000'";
		 $catEnd = $startD . $hours . $colon . $minutes . $endD; 

		//the form has been posted, so save it
		$sql = "INSERT INTO categories
								(categoryName, 
								categoryDesc, 
								categoryUser, 
								catStart,
								catEnd)
		   VALUES('" . mysql_real_escape_string($_POST['categoryName']) . "',
				  '" . mysql_real_escape_string($_POST['categoryDesc']) . "',
				  '" . mysql_real_escape_string($_SESSION['userName']) . "',
				   ADDTIME(CURTIME(), '0 3:0:0.000000'),
            	   ADDTIME(CURTIME(), $catEnd)
            	   )";

		$result = mysql_query($sql);
		if(!$result)
		{
			//something went wrong, display the error
			echo 'Error' . mysql_error();
		}
		else
		{
			echo 'New category succesfully added.';
		}
	}

include 'footer.php';
?>
