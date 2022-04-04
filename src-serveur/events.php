<?php
	// http://localhost/WebPlanningAPI/events.php

	header("Access-Control-Allow-Origin: *"); // CORS : AJAX JS calls accepted from all domains

	if (isset($_GET["type"])) {
		$filter_type = $_GET["type"];
	}
	else {
		$filter_type = "";
	}

	require_once(__DIR__."/_consts.inc.php");
	$data_path = __DIR__."/".datafolder;
	$fichiers = scandir($data_path);
	if (is_array($fichiers)) {
		$result = array();
		foreach($fichiers as $fichier) {
			if (substr($fichier,strlen($fichier)-5)==".json") {
				// print($fichier." oui");
				$json = json_decode(file_get_contents($data_path."/".$fichier));
				if (is_object($json) && (empty($filter_type) || ($json->type == $filter_type))) {
					$result[] = $json;
				}
			}
			else {
				// print($fichier." non");
			}
		}
	}
	else {
		$result = array();
	}

	header('Content-Type: application/json; charset=utf8');
	http_response_code(200);	
	print(json_encode($result));
