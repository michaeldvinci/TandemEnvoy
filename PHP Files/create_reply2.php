<?php

	include 'connect.php';

	$sql = "INSERT INTO
				replies(replyContent,
					  replyDate,
					  replyTopic,
					  replyBy,
					  replyUser)
			VALUES
				('" . mysql_real_escape_string($_POST['replyContent']) . "',
					  NOW(),
					  " . mysql_real_escape_string($_POST['replyTopic']) . ",
					  " . $_POST['replyBy'] . ",
					  '" . mysql_real_escape_string($_POST['replyUser']) . "'
				)";

	$result = mysql_query($sql);

	if(!$result)
    {
        echo '[{"success":"0"}]';
    }
    else
    {
        echo '[{"success":"1"}]';
    }

?>
