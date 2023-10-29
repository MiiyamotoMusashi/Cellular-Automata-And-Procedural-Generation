/// @description CA Map Maker


spawn_squares = function() {
	
	instance_destroy(obj_square);
	
	var _spacing = sprite_get_width(spr_square);
	for (var col = 0; col < my_map.width; col += 1) {
		for (var row = 0; row < my_map.height; row += 1) {
			if (my_map.map[col][row]) {
				instance_create_layer(col * _spacing, row * _spacing, layer, obj_square); 
			}
		}
	}

}

spawn_chance = global.spawn_chance;
create_limit = global.create_limit;
destroy_limit = global.destroy_limit;

my_map = new cellular_automata_map(60, 60, spawn_chance, create_limit, destroy_limit);
my_map.iterate(global.iterate);
spawn_squares();