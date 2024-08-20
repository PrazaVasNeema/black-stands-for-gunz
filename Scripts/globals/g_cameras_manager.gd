extends Node


var _cameras_dicrionary : Dictionary


func add_camera(camera_name : GameConstants.CAMERAS, camera : Camera3D):
	if _cameras_dicrionary.has(camera_name):
		push_error(GameConstants.CAMERAS.find_key(camera_name) + " was already added to the cameras dict")
	_cameras_dicrionary[camera_name] = camera


func set_current(camera_name : GameConstants.CAMERAS):
	var camera = _cameras_dicrionary.get(camera_name, null)
	if !camera:
		push_error(GameConstants.CAMERAS.find_key(camera_name) + " is not present in the cameras dict")
	
	(camera as Camera3D).current = true