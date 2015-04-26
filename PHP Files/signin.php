<?php

include 'connect.php';
include 'header.php';
 
echo '<h3>Sign in</h3>';
 
if(isset($_SESSION['signed_in']) && $_SESSION['signed_in'] == true) {
    echo 'You are already signed in, you can <a href="signout.php">sign out</a> if you want.';
}
else {
    if($_SERVER['REQUEST_METHOD'] != 'POST') {
        echo '<form method="post" action="">
            Username: <input type="text" name="userName" />
            Password: <input type="password" name="userPass">
            <input type="submit" value="Sign in" />
         </form>';
    }
    else {
         $errors = array();
         
        if(!isset($_POST['userName'])) {
            $errors[] = 'The username field must not be empty.';
        }
         
        if(!isset($_POST['userPass'])) {
            $errors[] = 'The password field must not be empty.';
        }
         
        if(!empty($errors)) {
            echo 'Uh-oh.. a couple of fields are not filled in correctly..';
            echo '<ul>';
            foreach($errors as $key => $value) {
                echo '<li>' . $value . '</li>';
            }
            echo '</ul>';
        }
        else {
            $sql = "SELECT 
                        userID,
                        userName,
                        userLevel
                    FROM
                        users
                    WHERE
                        userName = '" . mysql_real_escape_string($_POST['userName']) . "'
                    AND
                        userPass = '" . sha1($_POST['userPass']) . "'";
                         
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
}
 
include 'footer.php';

?>