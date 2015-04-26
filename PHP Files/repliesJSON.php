<?php

include 'connect.php';
 
$rTopic = (int)$_GET['rTopic'];
$rID = $_GET['rID'];

$sql = "SELECT * 
		FROM replies 
		WHERE replyTopic = '$rTopic'
		";

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