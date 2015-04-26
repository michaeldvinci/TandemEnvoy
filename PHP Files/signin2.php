<?php

include 'connect.php';

$userName = $_GET['userName'];
$userPass = $_GET['userPass'];
 
if(isset($_SESSION['signed_in']) && $_SESSION['signed_in'] == true) {
    echo 'You are already signed in, you can <a href="signout.php">sign out</a> if you want.';
}
else {
    $sql = "SELECT 
                    userID,
                    userName,
                    userLevel
                FROM
                    users
                WHERE
                    userName = '" . mysql_real_escape_string($_POST[$userName]) . "'
                AND
                    userPass = '" . sha1($_POST[$userPass]) . "'";
                     
        $result = mysql_query($sql);
        
        if(!$result) {
            echo 'Something went wrong while signing in. Please try again later.';
        }
        else {
            if(mysql_num_rows($result) == 0) {
                echo 'You have supplied a wrong user/password combination. Please try again.';
            }
            else {
                $_SESSION['signed_in'] = true;
                 
                while($row = mysql_fetch_assoc($result)) {
                    $_SESSION['userID']    = $row['userID'];
                    $_SESSION['userName']  = $row['userName'];
                    $_SESSION['userLevel'] = $row['userLevel'];
                }
                
                echo 'Welcome, ' . $_SESSION['userName'] . '. <a href="index.php">Proceed to the forum overview</a>.';
            }
        }
    }
}

?>