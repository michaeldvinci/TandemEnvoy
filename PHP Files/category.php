<?php
//category.php
include 'connect.php';
include 'header.php';

//first select the category based on $_GET['categoryID']
$sql = "SELECT
			categoryID,
			categoryName,
			categoryDesc
		FROM
			categories
		WHERE
			categoryID = " . mysql_real_escape_string($_GET['id']);

$result = mysql_query($sql);

if(!$result)
{
	echo 'The category could not be displayed, please try again later.' . mysql_error();
}
else
{
	if(mysql_num_rows($result) == 0)
	{
		echo 'This category does not exist.';
	}
	else
	{
		//display category data
		while($row = mysql_fetch_assoc($result))
		{
			echo '<h2>Topics in &prime;' . $row['categoryName'] . '&prime; category</h2><br />';
		}
	
		//do a query for the topics
		$sql = "SELECT	
					topicID,
					topicSubject,
					topicDate,
					topicCat
				FROM
					topics
				WHERE
					topicCat = " . mysql_real_escape_string($_GET['id']);
		
		$result = mysql_query($sql);
		
		if(!$result)
		{
			echo 'The topics could not be displayed, please try again later.';
		}
		else
		{
			if(mysql_num_rows($result) == 0)
			{
				echo 'There are no topics in this category yet.';
			}
			else
			{
				//prepare the table
				echo '<table border="1">
					  <tr>
						<th>Topic</th>
						<th>Created at</th>
					  </tr>';	
					
				while($row = mysql_fetch_assoc($result))
				{				
					echo '<tr>';
						echo '<td class="leftpart">';
							echo '<h3><a href="topic.php?id=' . $row['topicID'] . '">' . $row['topicSubject'] . '</a><br /><h3>';
						echo '</td>';
						echo '<td class="rightpart">';
							echo date('d-m-Y', strtotime($row['topicDate']));
						echo '</td>';
					echo '</tr>';
				}
			}
		}
	}
}

include 'footer.php';
?>
