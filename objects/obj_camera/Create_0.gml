global.view_target = obj_dante;

x_to = noone;
y_to = noone;

window_set_size(VIEW_WIDTH * VIEW_SCALE,VIEW_HEIGHT * VIEW_SCALE);
surface_resize(application_surface,VIEW_WIDTH * VIEW_SCALE,VIEW_HEIGHT * VIEW_SCALE);

window_center();

// Screen shake

shake_length = 0;

shake_time = 0;