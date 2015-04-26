<?php

	include 'connect.php';

	$sql = "INSERT INTO 
				topics(topicSubject,
					  topicDate,
					  topicCat,
					  topicBy,
					  topicUser)
		    VALUES
		   		('" . mysql_real_escape_string($_POST['topicSubject']) . "',
					  NOW(),
					  " . mysql_real_escape_string($_POST['topicCat']) . ",
					  " . $_POST['topicBy'] . ",
					  '" . mysql_real_escape_string($_POST['topicUser']) . "'
				)";
			 
	$result = mysql_query($sql);
	
	if(!$result)
	{
		echo 'Error' . mysql_error();
	}
	else
	{
		echo 'You have succesfully created your new topic</a>.';
	}

?>
