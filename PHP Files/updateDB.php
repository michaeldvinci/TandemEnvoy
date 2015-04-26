<?php

	include 'connect.php';

	$sql = "DELETE FROM categories WHERE catEnd < ADDTIME(CURRENT_TIME(), '0 3:0:0.000000')";

	$result = mysql_query($sql);

	if ($result) {
    	echo ('records removed');
	}else{
    	echo ('didnt remove records');
	}

?>
