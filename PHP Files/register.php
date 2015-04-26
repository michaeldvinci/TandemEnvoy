<?php
 
include 'connect.php';

if (isset ($_POST["userName"]) && isset ($_POST["userPass"])){
    $userName = $_POST["userName"];
    $userPass = $_POST["userPass"];
} else {
    $userName = "failure";
    $userPass = "failure";
}

// Insert value into DB
$sql = "INSERT INTO
                    users(userName, userPass, userEmail ,userDate, userLevel)
                VALUES('" . mysql_real_escape_string($_POST['userName']) . "',
                       '" . sha1($_POST['userPass']) . "',
                       '" . mysql_real_escape_string($_POST['userEmail']) . "',
                        NOW(),
                        0)";
$res = mysql_query($sql,$con) or die(mysql_error());

mysql_close($con);

if($res) {          
$response = array('status' => '1');                 
} else {
die("Query failed");
}

echo json_encode($res);
exit();
?>