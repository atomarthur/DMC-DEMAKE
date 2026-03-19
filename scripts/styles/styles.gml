enum STYLES 
{
	TRICKSTER = 0,
	SWORDMASTER,
	ROYALGUARD,
	GUNSLINGER
}


function state_trickster()
{
	
	hspd = lengthdir_x(dash_force, dir);
	
	dash_time = approach(dash_time, dash_distance, 1)
	
	if (dash_time >= dash_distance)
	{
		state = state_free;	
	}
	
}

function state_swordmaster()
{
		
}

function state_royalguard()
{
	
}

function state_gunslinger()
{
	
}