<?php
 
include 'connect.php';

$userName = $_GET['userName'];
$userPass = $_GET['userPass'];

$userPass = sha1($userPass);

$sql = "SELECT * FROM users WHERE (userName = '".$userName."') AND (userPass = '".$userPass."') ";

$result = mysql_query($sql);

if ($result = mysqli_query($con, $sql)) {
    $resultArray = array();
    $tempArray = array();
 
    while($row = $result->fetch_object()) {
        $tempArray = $row;
        array_push($resultArray, $tempArray);
        
        if($resultArray) {
            $row -> success = '1';   
            $result_string = json_encode($resultArray);
            echo $result_string;
        }
    }
}

if(!$resultArray) {
    echo '[{"success":"0"}]';
}

mysqli_close($con);
?>