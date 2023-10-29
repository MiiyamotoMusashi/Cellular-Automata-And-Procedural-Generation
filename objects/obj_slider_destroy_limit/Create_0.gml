value = 0;
move = false;
moved = false;

ChangeTarget = function() {
	if (instance_exists(obj_ca_map)) {
		var _value = value;
		
		if (move == false and moved == true) {
			with (obj_ca_map) {
				global.destroy_limit = _value;
				moved = false;
				instance_destroy(obj_ca_map);
				
				instance_create_layer(x, y, layer, obj_ca_map);
				my_map = new cellular_automata_map(60, 60, global.spawn_chance, global.create_limit, global.destroy_limit) ;
				my_map.iterate(global.iterate);
				spawn_squares();
			}
		}
	}
}

DrawSlider = function() {
	draw_self();
	image_speed = 0;
	image_xscale = 3;
	image_yscale = 3;
	x = window_get_width() * 0.705;
	y = window_get_height() * 0.4;
	
	var _x_button_pos = x + (sprite_width * value)
	
	draw_sprite_part_ext(spr_slider_bar, 1, 0, 0, sprite_width / 3 * value, sprite_height, x, y - sprite_yoffset, image_xscale, image_yscale, c_white, 1);
	draw_sprite_ext(spr_slider_button, 0, _x_button_pos, y, 3, 3, 0, c_white, 1);
}

// Alterando a posição do botão
ChangeValue = function() {
	ChangeTarget();
	
	var _x_button_pos = x + (sprite_width * value);
	var _y_button_pos = y;
	var _margin = 2;
	
	var _mouse_on = point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top - _margin, bbox_right, bbox_bottom + _margin);
	var _mouse_click = mouse_check_button(mb_left);
	var _mouse_pressed = mouse_check_button_pressed(mb_left);
	
	if (_mouse_on) {
		if (_mouse_pressed) {
			move = true;
		}
	}
	
	if (move == true) {
		if (_mouse_click) {
			value = (mouse_x - x) / sprite_width;
			value = clamp(value, 1, 5); // Limitando o valor entre 0 e 1
		}
		else {move = false; moved = true;}
	}
	
}