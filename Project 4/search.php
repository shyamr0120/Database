<?php

session_start();
processPageRequest();

function displaySearchForm()
{
	require_once "templates/search_form.html";
}

function displaySearchResults($searchString)
{
	$apiKey = '20e46cd4';
	/*Put the php variables in single quotes and the url in double quotes. This way we can simply put the php variable at its required position in the url without any errors.*/
	$search = urlencode($searchString);
	$results = file_get_contents("http://www.omdbapi.com/?apikey=$apiKey&s=$search&type=movie&r=json");
	$array = json_decode($results, true)["Search"];
	$_SESSION["count2"] = count($array);
	require_once "templates/results_form.html";
}

function processPageRequest()
{
	if($_POST == null)
	{
		displaySearchForm();
	}
	else
	{
		displaySearchResults($_POST["searchString"]);
		/*searchString is the 'name' given to the text field in which the user inputs the
		 keyword. This is the post data we recieve.*/ 
	}
}

?>
