<?php
 
include 'connect.php';

$userName = $_GET['userName'];
$userPass = $_GET['userPass'];

$userPass = md5($userPass);

$sql = "SELECT userID, userLevel FROM users WHERE (userName = '".$userName."') AND (userPass = '".$userPass."') ";

$result = mysql_query($sql);

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