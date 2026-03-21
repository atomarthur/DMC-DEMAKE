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
		image_index = image_number-1;
		screen_shake(12, 12);
		ground_stop_time--;
		
		if (ground_stop_time <= 0)
		{
			state = state_free;
		}
			
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

function state_stinger()
{
		
	if (stinger_time >= stinger_distance)
	{
		
		hspd = 0;
		
		sprite_index = spr_dante_thrust;
		image_speed = 1;
		
		if (image_index >= image_number-1)
		{
			image_index = image_number-1;
		}
		
		
		screen_shake(8, 8);
		
		stinger_stop_time--;
		
		if (stinger_stop_time <= 0)
		{
			state = state_free;		
		}	
	}
	
	else
	{
		sprite_index = spr_dante_stinger;
	
		hspd = lengthdir_x(stinger_force, dir);
	
		stinger_time = approach(stinger_time, stinger_distance, 1)
	}
	
	
}

function state_free()
{
	
	#region Movement

	var _right = keyboard_check(vk_right);
	var _left = keyboard_check(vk_left);
	var _up = keyboard_check(vk_up);
	var _down = keyboard_check(vk_down);
	
	var _jump = keyboard_check_pressed(ord("Z"));
	var _jump_down = keyboard_check(ord("Z"));
	
	var _style = keyboard_check_pressed(vk_shift);
	var _attack = keyboard_check_pressed(ord("X"));
	
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
			ground_stop_time = ground_stop_time_max;
			state = state_air_attack;	
		}
		
		else
		{		
			if (!_jump_down)
			{
				
				if (combo_reset <= 0)
				{
					combo_counter = 1;		
				}
		
				hspd = 0;
				spd = 0;
				
				switch (_up - _down) {
				    case 1:
						if (stinger_cooldown <= 0)
						{
							stinger_time = 0;
							stinger_cooldown = stinger_cooldown_max;
							stinger_stop_time = stinger_stop_time_max;
					        state = state_stinger;
						}
				        break;

					 case -1:
				        // code here
				        break;
						
					default:
						atk_cooldown = atk_cooldown_max;
						combo_reset = combo_reset_max;
			
						image_index = 0;
						state = state_attack;
						break;
				}
				
				
				
			}

		}
	}
	
	atk_cooldown--;
	combo_reset--;
	combo_end_cooldown--;
	stinger_cooldown --;
	
	// Style
	
	if (_style and style_cooldown <=0)
	{
		vspd = 0;
		hspd = 0;
		
		style_cooldown = style_cooldown_max;
		
		current_style.use(self, _up - _down);
	}
		
	style_cooldown --;
	
	#endregion
	
}



