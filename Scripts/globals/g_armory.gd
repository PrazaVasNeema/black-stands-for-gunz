extends Node



const path = "res://resources/guns/"

var player_teikyou : PlayerTeikyou
var guns_armory_data_array : Array[GunArmoryData]
var currently_equiped : Dictionary

func _ready():
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):
				var resource_path = path + file_name
				var resource = load(resource_path)
				if resource is GunArmoryData:
					# print("Loaded GunArmoryData: ", resource.gun_description)
					guns_armory_data_array.append(resource)
			# if dir.current_is_dir():
			# 	print("Found directory: " + file_name)
			# else:

			# 	print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func equip_gun(gun_num : int, slot_num : int):
	if gun_num == -1:
		player_teikyou.equip_gun(null, slot_num)
	else:
		player_teikyou.equip_gun(guns_armory_data_array[gun_num].gun_scene, slot_num)
	currently_equiped[slot_num] = gun_num


func get_armory_data() -> Dictionary:
	var return_args : Dictionary
	return_args["currently_equiped"] = currently_equiped
	return_args["guns_armory_data_array"] = guns_armory_data_array
	return return_args