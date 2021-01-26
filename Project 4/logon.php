<?php

processPageRequest();

function authenticateUser($username, $password)
{
	$line = file_get_contents("data/credentials.db");
	$line_arr = explode(",", $line);
	$user = $line_arr[0];
	$pass = $line_arr[1];
	if($user == $username && $pass == $password)
	{
		session_start();
		$_SESSION["display"] = $line_arr[2];
		$_SESSION["email"] = $line_arr[3];
		header("Location: index.php");		
	}
	else
	{
		displayLoginForm("Invalid username and/or password.");
	}
}

function displayLoginForm($message="")
{
	require_once("templates/logon_form.html");
}

function processPageRequest()
{
	session_destroy();

	if($_POST==null)
	{
		displayLoginForm();
	}
	else
	{
		authenticateUser($_POST["username"], $_POST["password"]);
	}
}
?>
