// Script Asset for Cellular Automata

function cellular_automata_map(_width, _height, _spawn_chance, _create_limit, _destroy_limit) constructor {
	
	//set variables
	width = _width;
	height = _height;
	create_limit = _create_limit;
	destroy_limit = _destroy_limit;

	//create and randomize map
	for (var col = width - 1; col >= 0; col -= 1) {
		for (var row = height - 1; row >= 0; row -= 1) {
			map[col][row] = random(1) <= _spawn_chance;
		}
	}
	
	//the iterate function
	static iterate = function(_num) {
		
		repeat(_num) {
			
			//create a new map so as not to overwrite data while we're collecting it
			var _new_map = [];
			
			//loop through old map, and create a new map with the next generation of cells
			for (var col = 0; col < width; col += 1) {
				for (var row = 0; row < height; row += 1) {
					
					//get a count of neighbors
					var _col_dif, _row_dif, _count;
					_count = 0;
					for (var col_offset = -1; col_offset < 2; col_offset += 1) {
						for (var row_offset = -1; row_offset < 2; row_offset += 1) {
							_col_dif = col + col_offset;
							_row_dif = row + row_offset;
							if (_col_dif < 0) || (_row_dif < 0) || (_col_dif >= width) || (_row_dif >= height) {
								_count += 1;
							} else if (_col_dif == 0) && (_row_dif == 0) {
								continue;
							} else if (map[_col_dif][_row_dif]) {
								_count += 1;
							}
						}
					}					
					
					//apply rules for changing
					if (map[col][row]) {
						_new_map[col][row] = _count > destroy_limit;
					} else {
						_new_map[col][row] = _count > create_limit;
					} 
					
				}
			}
			
			//replace the old map with the new map
			map = _new_map;	
		}
	
	}

}



function cellular_automata_island_map(_width, _height, _spawn_chance) constructor {
	
	//set variables
	width = _width;
	height = _height;

	//create island map
	island_map = array_create(width, 0);
	for (var i = 0; i < width; i += 1) {
		island_map[i] = array_create(height, 0);
	}
	
	//randomize map
	for (var col = 5; col < (width - 5); col += 1) {
		for (var row = 5; row < (height - 5); row += 1) {			
			island_map[col][row] = random(1) <= _spawn_chance ? 60 : 10;  		
		}	
	}
	
	
	//the iterate function
	static iterate = function(_num) {
		
		repeat(_num) {
			
			//create a new map so as not to overwrite data while we're collecting it
			var _new_map = array_create(width, 0);
			for (var i = 0; i < width; i += 1) {
				_new_map[i] = array_create(height, 0);
			}
			
			//loop through old map, and create a new map with the next generation of cells
			for (var col = 1; col < (width - 1); col += 1) {
				for (var row = 1; row < (height - 1); row += 1) {
					
					var _neighbors, _self;
			        _neighbors = 0;  
			        _self = island_map[col][row];
			        for (var i = -1; i <= 1; i++) {
			          for (var j = -1; j <= 1; j++) {
			            _neighbors += island_map[col + i][row + j];
			          }
			        }
				
					_neighbors -= _self;
					_neighbors /= 8;
					
					//apply rules for changing
				    if (_neighbors < 40) {
				        _new_map[col][row] = _self + (random(_neighbors - _self));
				    }else if (_self > _neighbors) {
				        _new_map[col][row] = _self + (random_range(-10, 10));
				    } else {
				        _new_map[col][row] = _self + (random(_neighbors/5));
				    }
					
				}
			}
			
			//replace the old map with the new map
			island_map = _new_map;	
		}
	
	}

}