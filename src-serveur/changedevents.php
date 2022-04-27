<?php
	// http://localhost/WebPlanningAPI/changedevents.php

	require_once(__DIR__."/_functions.inc.php");
	// debug("_server=".var_export($_SERVER,true));
	// debug("_get=".var_export($_GET,true));
	// debug("_post=".var_export($_POST,true));

	require_once(__DIR__."/_consts.inc.php");
	$data_path = __DIR__."/".datafolder;

	$erreur_param = false;
	if ((! $erreur_param) && isset($_POST["auth"])) {
		$auth = trim($_POST["auth"]);
		$erreur_param = (pub_auth_token != $auth);
		// debug("err1 = ".var_export($erreur_param,true));
	}
	else {
		$erreur_param = true;
	}

	if ((! $erreur_param) && isset($_POST["events"])) {
		$events = trim($_POST["events"]);
		if (empty($events)) {
			$erreur_param = true;
			// debug("err2 = ".var_export($erreur_param,true));
		}
		else {
			$json = json_decode($events);
			if (! is_array($json)) {
				$erreur_param = true;
				// debug("err3 = ".var_export($erreur_param,true));
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
			// debug("err4 = ".var_export($erreur_param,true));
		}
		else {
			require_once(__DIR__."/_functions.inc.php");
			$erreur_param = (! checkVerifChecksum($v, $auth, priv_change_token, $events));
			// debug("err5 = ".var_export($erreur_param,true));
			// debug($auth);
			// debug($events);
			// debug(priv_change_token);
			// debug(getVerifChecksum($auth, $events, priv_change_token, "", "", "", false));
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
		$result = array();
		foreach($json as $event) {
			if (is_object($event) && isset($event->uid) && file_exists($data_path."/".($FilteredID=FilterID($event->uid)).".json")) {
				file_put_contents($data_path."/".$FilteredID.".json", json_encode($event));
				$result[] = $event->uid;
			}
		}
		header('Content-Type: application/json; charset=utf8');
		http_response_code(200);	
		print(json_encode($result));
	}

