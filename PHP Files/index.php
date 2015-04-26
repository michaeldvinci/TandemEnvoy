<?php
//createCat.php
include 'connect.php';
include 'header.php';

$sql = "SELECT
			categories.categoryID,
			categories.categoryName,
			categories.categoryDesc,
			COUNT(topics.topicID) AS topics
		FROM
			categories
		LEFT JOIN
			topics
		ON
			topics.topicID = categories.categoryID
		GROUP BY
			categories.categoryName, categories.categoryDesc, categories.categoryID";

$result = mysql_query($sql);

if(!$result)
{
	echo 'The categories could not be displayed, please try again later.';
}
else
{
	if(mysql_num_rows($result) == 0)
	{
		echo 'No categories defined yet.';
	}
	else
	{
		//prepare the table
		echo '<table border="1">
			  <tr>
				<th>Category</th>
				<th>Last topic</th>
			  </tr>';	
			
		while($row = mysql_fetch_assoc($result))
		{				
			echo '<tr>';
				echo '<td class="leftpart">';
					echo '<h3><a href="category.php?id=' . $row['categoryID'] . '">' . $row['categoryName'] . '</a></h3>' . $row['categoryDesc'];
				echo '</td>';
				echo '<td class="rightpart">';
				
				//fetch last topic for each cat
					$topicsql = "SELECT
									topicID,
									topicSubject,
									topicDate,
									topicCat
								FROM
									topics
								WHERE
									topicCat = " . $row['categoryID'] . "
								ORDER BY
									topicDate
								DESC
								LIMIT
									1";
								
					$topicsresult = mysql_query($topicsql);
				
					if(!$topicsresult)
					{
						echo 'Last topic could not be displayed.';
					}
					else
					{
						if(mysql_num_rows($topicsresult) == 0)
						{
							echo 'no topics';
						}
						else
						{
							while($topicrow = mysql_fetch_assoc($topicsresult))
							echo '<a href="topic.php?id=' . $topicrow['topicID'] . '">' . $topicrow['topicSubject'] . '</a> at ' . date('d-m-Y', strtotime($topicrow['topicDate']));
						}
					}
				echo '</td>';
			echo '</tr>';
		}
	}
}

include 'footer.php';
?>
