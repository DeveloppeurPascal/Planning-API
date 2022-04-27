<?php
	if (($_SERVER["SERVER_ADDR"] == "127.0.0.1") || ($_SERVER["SERVER_ADDR"] == "::1")) {
		// localhost
		define('datafolder','data-h4g5jh4fgh524f');
		define('pub_auth_token','{27934C3B-2F9B-46A7-9A26-4DE50404EE40}');
		define('priv_add_token','{9B257CE7-9C2D-4EE2-BEE4-0076418D0F15}');
		define('priv_change_token','{8A97BCA1-AF2B-4D51-87FD-3E34EF95616A}');
		define('priv_remove_token','{D3ABAE5C-074A-4B71-8116-2865418D8388}');
	}
	else if (file_exists(__DIR__."/_PRIVE/_consts.inc.php")) {
		// real server IP
		require_once(__DIR__."/_PRIVE/_consts.inc.php");
	}
	else {
		die("No setup found !");
	}
