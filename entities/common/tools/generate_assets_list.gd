@tool
extends EditorScript

func _run():
	var path = "res://entities/common/guns/"
	var output_file = "res://scripts/gun_armory_list.gd"
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var file = FileAccess.open(output_file, FileAccess.WRITE)
		file.store_line("extends Node\n\nvar guns_armory_data_array = [")
		while file_name != "":
			if file_name.ends_with(".tres"):
				file.store_line('    preload("' + path + file_name + '"),')
			file_name = dir.get_next()
		file.store_line("]")
		file.close()
	print("Gun list generated!")
