function MultiplyUINT256(uint256 x, uint256 y) returns mathint
	{
		return x * y;
	}

function requireValidUser(address user)
	{
		require (user != 0) && (user != currentContract);
	}