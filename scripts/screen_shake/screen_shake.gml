function screen_shake(_val1, _val2)
{
	with (obj_camera)
	{
		shake_length = _val1;
		shake_time = _val2;
		
		alarm[0] = shake_time;
	}
}