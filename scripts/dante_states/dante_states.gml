function state_attack()
{
	sprite_index = asset_get_index("spr_dante_combo_" + string(combo_counter));
	image_speed = 1;
	
	if (image_index >= image_number-1)
	{
		combo_counter ++;
		state = state_free;	
	}
}	

function state_air_attack()
{
	var _ground = place_meeting(x, y + 1, par_wall);
	
	if (_ground)
	{
		state = state_free;
	}
	
	else
	{
		sprite_index = spr_dante_air_attack;
		image_speed = 1;
		
		if (image_index <= 2) 
		{
			vspd = 0;	
		}
		
		else
		{
		
			if (image_index >= image_number-1)
			{
			image_speed = 0;
			}	
			vspd += helm_breaker_force;
		}
		
		
		
	}
	

}	

function state_free()
{
	
	#region Movement

	var _right = keyboard_check(vk_right);
	var _left = keyboard_check(vk_left);
	var _jump = keyboard_check_pressed(ord("Z"));
	var _jump_down = keyboard_check(ord("Z"));
	var _style = keyboard_check(vk_shift);
	
	var _move = (_right - _left);
	var _ground = place_meeting(x, y + 1, par_wall);
	
	vspd += grv;
	vspd = clamp(vspd, vspd_min, vspd_max)

	if (_move != 0)
	{
		dir = point_direction(0, 0, _move, 0);
		spd = approach(spd, spd_max, acc);
	
		x_scale = _move;
		sprite_index = spr_dante_run;
		image_speed = 1;
	}

	else
	{
		spd = approach(spd, 0, dcc)	;
	
		sprite_index = spr_dante_idle;
		image_speed = 0;
	}

	hspd = lengthdir_x(spd, dir);
	
	// Jump
	
	if (_ground)
	{
		jump = false;	
	}
	else
	{
		sprite_index = spr_dante_jump;
	}
	
	if (!_jump_down and vspd < 0 and jump)
	{
		vspd = max(vspd, -jump_height/3.2);
	}	
	
	if (_ground and _jump)
	{
		vspd = 0;
		vspd -= jump_height;	
		jump = true;
	}
	
	#endregion
	
	#region Abilities
	
	// Attack

	var _attack = keyboard_check_pressed(ord("X"));
	
	if (combo_counter > 3)
	{
		combo_counter = 1;
		combo_end_cooldown = combo_end_cooldown_max;
	}

	if (_attack and atk_cooldown <= 0 and combo_end_cooldown <= 0)
	{
		
		if (!_ground)
		{
			hspd = 0;
			vspd = 0;
			state = state_air_attack;	
		}
		
		else
		{
		
			if (combo_reset <= 0)
			{
				combo_counter = 1;		
			}
		
			hspd = 0;
			spd = 0;
		
			atk_cooldown = atk_cooldown_max;
			combo_reset = combo_reset_max;
			
			image_index = 0;
			state = state_attack;
		}
	}
	
	atk_cooldown--;
	combo_reset--;
	combo_end_cooldown--;
	
	// Style
	
	if (_style and style_cooldown <=0)
	{
		
		vspd = 0;
		hspd = 0;
		
		style_cooldown = style_cooldown_max;
		
		switch (current_style) 
		{
		    case STYLES.TRICKSTER:
				dash_time = 0;
		        state = state_trickster;
		        break;
				
			 case STYLES.SWORDMASTER:
		        // code here
		        break;
				
			 case STYLES.ROYALGUARD:
		        // code here
		        break;
				
			 case STYLES.GUNSLINGER:
		        // code here
		        break;
				
			default:
		        // code here
		        break;
		}
		
		
	}
	
	style_cooldown --;
	
	#endregion
	
}



