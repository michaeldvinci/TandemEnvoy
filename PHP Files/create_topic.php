<?php
//create_topic.php
include 'connect.php';
include 'header.php';

echo '<h2>Create a topic</h2>';
if($_SESSION['signed_in'] == false)
{
	//the user is not signed in
	echo 'Sorry, you have to be <a href="/forum/signin.php">signed in</a> to create a topic.';
}
else
{
	//the user is signed in
	if($_SERVER['REQUEST_METHOD'] != 'POST')
	{	
		//the form hasn't been posted yet, display it
		//retrieve the categories from the database for use in the dropdown
		$sql = "SELECT
					categoryID,
					categoryName,
					categoryDesc
				FROM
					categories";
		
		$result = mysql_query($sql);
		
		if(!$result)
		{
			//the query failed, uh-oh :-(
			echo 'Error while selecting from database. Please try again later.';
		}
		else
		{
			if(mysql_num_rows($result) == 0)
			{
				//there are no categories, so a topic can't be posted
				if($_SESSION['userLevel'] == 1)
				{
					echo 'You have not created categories yet.';
				}
				else
				{
					echo 'Before you can post a topic, you must wait for an admin to create some categories.';
				}
			}
			else
			{
		
				echo '<form method="post" action="">
					Subject: <input type="text" name="topicSubject" /><br />
					Category:'; 
				
				echo '<select name="topicCat">';
					while($row = mysql_fetch_assoc($result))
					{
						echo '<option value="' . $row['categoryID'] . '">' . $row['categoryName'] . '</option>';
					}
				echo '</select><br />';	
					
				echo 'Message: <br /><textarea name="replyContent" /></textarea><br /><br />
					<input type="submit" value="Create topic" />
				 </form>';
			}
		}
	}
	else
	{
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
							   topicBy,
							   topicUser)
				   VALUES('" . mysql_real_escape_string($_POST['topicSubject']) . "',
							   NOW(),
							   " . mysql_real_escape_string($_POST['topicCat']) . ",
							   " . $_SESSION['userID'] . ",
							   '" . mysql_real_escape_string($_SESSION['userName']) . "'
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
								  replyBy,
								  replyUser)
						VALUES
							('" . mysql_real_escape_string($_POST['replyContent']) . "',
								  NOW(),
								  " . $topicid . ",
								  " . $_SESSION['userID'] . ",
							   '" . mysql_real_escape_string($_SESSION['userName']) . "'
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
	}
}

include 'footer.php';
?>
