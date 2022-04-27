<?php

	// return a checksum value for "verif" URL param
	// https://trucs-de-developpeur-web.fr/calculer-et-verifier-un-checksum-pour-dialoguer-avec-l-exterieur.html
	function getVerifChecksum($param, $key1="", $key2="", $key3="", $key4="", $key5="", $public=true)
	{
		$verif = "";
		if (is_array($param)) {
			$par = "";
			foreach($param as $value) {
				$par .= $value;
			}
			$verif = md5($par.$key1.$key2.$key3.$key4.$key5);
		}
		else {
			$verif = md5($param.$key1.$key2.$key3.$key4.$key5);
		}
		return ($public)?substr($verif,mt_rand(0,strlen($verif)-10),10):$verif;
	}
	
	// check a "verif" checksum value
	// return TRUE if ok, FALSE if not
	// https://trucs-de-developpeur-web.fr/calculer-et-verifier-un-checksum-pour-dialoguer-avec-l-exterieur.html
	function checkVerifChecksum($verif, $param, $key1="", $key2="", $key3="", $key4="", $key5="")
	{
		if ((strlen($verif) < 1) && isset($_POST["verif"]))
		{
			$verif = $_POST["verif"];
		}
		if ((strlen($verif) < 1) && isset($_GET["verif"]))
		{
			$verif = $_GET["verif"];
		}
		return (false !== strpos(getVerifChecksum($param, $key1, $key2, $key3, $key4, $key5, false),$verif));
	}

	function GenerateID($nb_max = 30) {
		$lettres = "0123456789abcdefghijklmnopqrstuvwxyzAZERTYUIOPMLKJHGFDSQWXCVBN";
		$result = "";
		for ($i = 0; $i < $nb_max; $i++) {
			$result .= substr($lettres, mt_rand(0, strlen($lettres)-1), 1);
		}
		return $result;
	}

	function debug($txt) {
		file_put_contents(__DIR__."/log.txt", @file_get_contents(__DIR__."/log.txt")."\r\n".$txt);
	}

	function FilterID($id) {
		$lettres = "0123456789abcdefghijklmnopqrstuvwxyzAZERTYUIOPMLKJHGFDSQWXCVBN";
		$result = "";
		for ($i = 0; $i < strlen($id); $i++) {
			if (false !== strpos($lettres, ($c = substr($id,$i,1)))) {
				$result .= $c;
			}
			else {
				debug($id);
				die("ID incorrect");
			}
		}
		return $result;
	}
