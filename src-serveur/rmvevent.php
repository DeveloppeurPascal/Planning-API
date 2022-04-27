<?php
	// http://localhost/WebPlanningAPI/rmvevent.php

	require_once(__DIR__."/_consts.inc.php");
	$data_path = __DIR__."/".datafolder;

	$erreur_param = false;
	if ((! $erreur_param) && isset($_POST["auth"])) {
		$auth = trim($_POST["auth"]);
		$erreur_param = (pub_auth_token != $auth);
	}
	else {
		$erreur_param = true;
	}
	
	if ((! $erreur_param) && isset($_POST["id"])) {
		$id = trim($_POST["id"]);
		if (empty($id)) {
			$erreur_param = true;
		}
	}
	else {
		$erreur_param = true;
	}
	
	if ((! $erreur_param) && isset($_POST["v"])) {
		$v = trim($_POST["v"]);
		if (empty($v)) {
			$erreur_param = true;
		}
		else {
			require_once(__DIR__."/_functions.inc.php");
			$erreur_param = (! checkVerifChecksum($v, $auth, priv_remove_token, $id));
		}
	}
	else {
		$erreur_param = true;
	}
	
	if ($erreur_param) {
		header('Content-Type: text/plain; charset=utf8');
		http_response_code(400); // bad request
		print("params error");
		exit;
	}
	else {
		header('Content-Type: text/plain; charset=utf8');
		if (is_file($data_path."/".($FilteredID=FilterID($id)).".json")) {
			@unlink($data_path."/".$FilteredID.".json");
			http_response_code(200);
		}
		else {
			http_response_code(404);
		}
	}
