enum STYLES 
{
	TRICKSTER = 0,
	SWORDMASTER,
	ROYALGUARD,
	GUNSLINGER
}

global.styles_struct = 
{
	
	trickster: 
	{
		name: "Trickster",
		use: function(_player, _direction)
		{
			
			switch (_direction) 
			{
			    case 0:
					_player.dash_time = 0;
			        _player.state = state_trickster_neutral
			        break;
				case 1:
					
			        break;
					
				case -1:
			        // code here
			        break;
					
			    default:
			        // code here
			        break;
					
			}
			
		}
	},
	
	swordmaster: {},
	royalguard: {},
	gunslinger: {}
	
}


function state_trickster_neutral()
{
	
	sprite_index = spr_dante_dash;
	
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