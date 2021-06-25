<?php
header("Access-Control-Allow-Origin: *");
	include 'config.php';
	$queryResult = $koneksi->query("SELECT *FROM tampilan");
	$result = array();
	while($fetchData = $queryResult-> fetch_assoc()){
		$result[]= $fetchData;
	}
	echo json_encode($result);
?>