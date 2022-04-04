<?php
	// http://localhost/WebPlanningAPI/newevent.php

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
	
	if ((! $erreur_param) && isset($_POST["event"])) {
		$event = trim($_POST["event"]);
		if (empty($event)) {
			$erreur_param = true;
		}
		else {
			$json = json_decode($event);
			if (! is_object($json)) {
				$erreur_param = true;
			}
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
			$erreur_param = (! checkVerifChecksum($v, $auth, $event, priv_add_token));
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
		do {
			$json->uid = GenerateID(20);
		} while (file_exists($data_path."/".$json->uid.".json"));
		file_put_contents($data_path."/".$json->uid.".json", json_encore($json));
		header('Content-Type: text/plain; charset=utf8');
		http_response_code(200);
		print($json->uid);
	}
