// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function global_variables(){

}
randomize();

global.spawn_chance = random_range(.2, .8);
global.create_limit = random_range(1, 5);
global.destroy_limit = random_range(1, 5);
global.iterate = random_range(1, 10);