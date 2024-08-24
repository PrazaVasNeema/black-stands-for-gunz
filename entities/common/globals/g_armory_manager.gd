extends Node

var gun_drums_array : Array[GunDrum]

var guns_armory_data_array = [
	preload("res://entities/common/guns/power_modules/gun_scenes/testing_gun_green.tscn"),
	preload("res://entities/common/guns/power_modules/gun_scenes/testing_gun_red.tscn"),
]


func load_random_gun(drum_num : int):
	var gun_scene = guns_armory_data_array[randi() % guns_armory_data_array.size()]
	print(str(gun_scene))
	var gun_entity : GunEntity = (gun_scene as PackedScene).instantiate()
	(gun_drums_array[drum_num] as GunDrum).roll(gun_entity)
