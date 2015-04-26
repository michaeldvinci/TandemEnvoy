<?php

include 'connect.php';

error_reporting(E_ERROR | E_WARNING | E_PARSE | E_NOTICE);

    $sql = "INSERT INTO
                    users(userName, userPass, userEmail ,userDate, userLevel)
                VALUES('" . mysql_real_escape_string($_GET['userName']) . "',
                       '" . sha1($_GET['userPass']) . "',
                       '" . mysql_real_escape_string($_GET['userEmail']) . "',
                        NOW(),
                        1)";
                         
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