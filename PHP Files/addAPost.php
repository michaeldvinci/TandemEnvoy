<?php

include 'connect.php';

$sql = "INSERT INTO categories(categoryName, categoryDesc, catEnd, catStart)
           VALUES('" . mysql_real_escape_string($_GET['categoryName']) . "',
                 '" . mysql_real_escape_string($_GET['categoryDesc']) . "',
                ADDTIME(CURRENT_TIME(), '1 1:1:1.000002'),
                 CURRENT_TIME())";
$result = mysql_query($sql);
if(!$result)
{
    //something went wrong, display the error
    echo 'Error' . mysql_error();
}
else
{
    $response = array('status' => '1');
}

echo json_encode($response);

mysql_close($conn);

?>