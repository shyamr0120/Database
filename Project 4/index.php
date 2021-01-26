<?php

session_start();
require_once ("/home/common/mail.php");
processPageRequest();

function addMovieToCart($movieID)
{
	$movie_arr = readMovieData();
	array_push($movie_arr, $movieID);
	writeMovieData($movie_arr);
	displayCart();
}

function checkout($name, $address)
{
	ob_start();/*It remebers everything after this statement but doesn't do anything with it (doesn't given an ouptut)*/
	$_SESSION["check"] = 1;
	$main_arr = readMovieData();
	require_once ("templates/cart_form.html");
	$receipt = ob_get_contents();/*We give the remembered content to $reciept so that we may use it in our sendMail() function*/
	ob_end_clean();/*Remembered data is removed/cleaned*/
	$_SESSION["check"] = 0;

	$result = sendMail(432932197, $address, $name, "Your Receipt from myMovies!", $receipt);
	if($result == 0)
	{
		echo "The email message was sent successfully";
		echo "<br><br>";
		echo "<a href = 'index.php'>Return to Shopping Cart</a>";
		return;
	}
	if($result >= 1 && $result <=59)
        {
		echo "" . $result . " second(s) before next email can be sent. Please try refreshing the page afterwards.";
	        echo "<br><br>";
	        echo "<a href = 'index.php'>Return to Shopping Cart</a>";
		return;
        }
	if($result == -1)
        {
		echo "An error occurred while sending the email message (email not sent). Please try refreshing the page.";
	        echo "<br><br>";
	        echo "<a href = 'index.php'>Return to Shopping Cart</a>";
		return;
        }
	if($result == -2)
        {
		echo "Email ID is invalid (email not sent)";
	        echo "<br><br>";
	        echo "<a href = 'index.php'>Return to Shopping Cart</a>";
		return;
        }
	if($result == -3)
        {
		echo "An error occurred while accessing the database (email not sent)";
	        echo "<br><br>";
	        echo "<a href = 'index.php'>Return to Shopping Cart</a>";
		return;
        }
}

function displayCart()
{
	$main_arr = readMovieData();
	$_SESSION ["count"] = count($main_arr);
	require_once ("templates/cart_form.html");
}

function processPageRequest()
{
	$_SESSION["check"] = 0;
	if($_GET["action"] == null)
	{
		displayCart();
	}
	else
	{
		if($_GET["action"] == "add")
		{
			addMovieToCart($_GET["movie_id"]);
		}
	        if($_GET["action"] == "checkout")
	        {
		        checkout($_SESSION["display"], $_SESSION["email"]);
	        }
                if($_GET["action"] == "remove")
	        {
	                removeMovieFromCart($_GET["movie_id"]);
		}
		if($_GET["action"] == "logoff")
                {
			logout();
                }
        }
}

function logout()
{
	header("Location: logon.php");
}

function readMovieData()
{
	$line = file_get_contents("data/cart.db");
	$line_arr = array();
	if(strlen($line)!=0 )
       	{
		     $line_arr = explode(",", $line);
	}
	return $line_arr;
}

function removeMovieFromCart($movieID)
{
	$movie_arr = readMovieData();
	$length = count($movie_arr);
	for($i = 0; $i < $length; $i++)
	{
		if($movie_arr[$i] == $movieID)
		{
			unset($movie_arr[$i]);
		}
	}
	writeMovieData($movie_arr);
	displayCart();
}

function writeMovieData($array)
{
	$line = implode(",", $array);
	file_put_contents("data/cart.db", $line);
}

?>
