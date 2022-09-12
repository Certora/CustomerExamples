function requireValidUser(address user)
	{
		require (user != 0) && (user != currentContract);
	}