<?php

include 'connect.php';
 
$tID = (int)$_GET['tID'];

$sql = "SELECT * FROM topics WHERE topicCat = '$tID' ";

if ($result = mysqli_query($con, $sql))
{
	$resultArray = array();
	$tempArray = array();
 
 	while($row = $result->fetch_object())
	{
		$tempArray = $row;
	    array_push($resultArray, $tempArray);
	}
 
	echo json_encode($resultArray);
}
 
mysqli_close($con);
?>