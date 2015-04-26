<?php
//create_cat.php
include 'connect.php';
include 'header.php';

$sql = "SELECT
			topicID,
			topicSubject
		FROM
			topics
		WHERE
			topics.topicID = " . mysql_real_escape_string($_GET['id']);
			
$result = mysql_query($sql);

if(!$result)
{
	echo 'The topic could not be displayed, please try again later.';
}
else
{
	if(mysql_num_rows($result) == 0)
	{
		echo 'This topic doesn&prime;t exist.';
	}
	else
	{
		while($row = mysql_fetch_assoc($result))
		{
			//display post data
			echo '<table class="topic" border="1">
					<tr>
						<th colspan="2">' . $row['topicSubject'] . '</th>
					</tr>';
		
			//fetch the posts from the database
			$replies_sql = "SELECT
						replies.replyTopic,
						replies.replyContent,
						replies.replyDate,
						replies.replyBy,
						users.userID,
						users.userName
					FROM
						replies
					LEFT JOIN
						users
					ON
						replies.replyBy = users.userID
					WHERE
						replies.replyTopic = " . mysql_real_escape_string($_GET['id']);
						
			$replies_result = mysql_query($replies_sql);
			
			if(!$replies_result)
			{
				echo '<tr><td>The posts could not be displayed, please try again later.</tr></td></table>';
			}
			else
			{
			
				while($replies_row = mysql_fetch_assoc($replies_result))
				{
					echo '<tr class="topic-post">
							<td class="user-post">' . $replies_row['userName'] . '<br/>' . date('d-m-Y H:i', strtotime($replies_row['replyDate'])) . '</td>
							<td class="post-content">' . htmlentities(stripslashes($replies_row['replyContent'])) . '</td>
						  </tr>';
				}
			}
			
			if(!$_SESSION['signed_in'])
			{
				echo '<tr><td colspan=2>You must be <a href="signin.php">signed in</a> to reply. You can also <a href="signup.php">sign up</a> for an account.';
			}
			else
			{
				//show reply box
				echo '<tr><td colspan="2"><h2>Reply:</h2><br />
					<form method="post" action="reply.php?id=' . $row['topicID'] . '">
						<textarea name="reply-content"></textarea><br /><br />
						<input type="submit" value="Submit reply" />
					</form></td></tr>';
			}
			
			//finish the table
			echo '</table>';
		}
	}
}

include 'footer.php';
?>