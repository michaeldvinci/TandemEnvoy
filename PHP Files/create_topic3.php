<?php
//create_topic.php
include 'connect.php';


//start the transaction
		$query  = "BEGIN WORK;";
		$result = mysql_query($query);
		
		if(!$result)
		{
			//Damn! the query failed, quit
			echo 'An error occured while creating your topic. Please try again later.';
		}
		else
		{
	
			//the form has been posted, so save it
			//insert the topic into the topics table first, then we'll save the post into the posts table
			$sql = "INSERT INTO 
						topics(topicSubject,
							   topicDate,
							   topicCat,
							   topicBy)
				   VALUES('" . mysql_real_escape_string($_POST['topicSubject']) . "',
							   NOW(),
							   " . mysql_real_escape_string($_POST['topicCat']) . ",
							   " . $_SESSION['userID'] . "
							   )";
					 
			$result = mysql_query($sql);
			if(!$result)
			{
				//something went wrong, display the error
				echo 'An error occured while inserting your data. Please try again later.<br /><br />' . mysql_error();
				$sql = "ROLLBACK;";
				$result = mysql_query($sql);
			}
			else
			{
				//the first query worked, now start the second, posts query
				//retrieve the id of the freshly created topic for usage in the posts query
				$topicid = mysql_insert_id();
				
				$sql = "INSERT INTO
							replies(replyContent,
								  replyDate,
								  replyTopic,
								  replyBy)
						VALUES
							('" . mysql_real_escape_string($_POST['replyContent']) . "',
								  NOW(),
								  " . $topicid . ",
								  " . $_SESSION['userID'] . "
							)";
				$result = mysql_query($sql);
				
				if(!$result)
				{
					//something went wrong, display the error
					echo 'An error occured while inserting your post. Please try again later.<br /><br />' . mysql_error();
					$sql = "ROLLBACK;";
					$result = mysql_query($sql);
				}
				else
				{
					$sql = "COMMIT;";
					$result = mysql_query($sql);
					
					//after a lot of work, the query succeeded!
					echo 'You have succesfully created <a href="topic.php?id='. $topicid . '">your new topic</a>.';
				}
			}
		}

?>
