function addMovie(movieID)
{
	window.location.replace("./index.php?action=add&movie_id=" + movieID);
	return true;
}

function confirmCheckout()
{
	if(window.confirm("Are you sure you wish to checkout from myMovies Xpress?") == true)
	{
		window.location.replace("./index.php?action=checkout");
		return true;
	}
	else
	{
		return false;
	}
}

function confirmLogout()
{
	if(window.confirm("Are you sure you wish to logout from myMovies Xpress?") == true)
	{
		window.location.replace("./index.php?action=logoff");
	        return true;
        }
        else
        {
                return false;
        }
}

function confirmRemove(title, movieID)
{
	if(window.confirm("Are you sure you wish to remove the selected movie?") == true)
        {
	        window.location.replace("./index.php?action=remove&movie_id=" + movieID);
	        return true;
        }
        else
        {
                return false;
        }
}
