extends Node3D

var projectiles_holder : Node3D

var _world_space : PhysicsDirectSpaceState3D
var _start : Vector3
var _end : Vector3
var _result_raw : Dictionary


func _ready() -> void:
	projectiles_holder = Node3D.new()
	add_child(projectiles_holder)


func  _physics_process(delta: float) -> void:
	_world_space = get_world_3d().direct_space_state


func get_ws_position_from_mouse(camera : Camera3D, mouse_position : Vector2, hit_layer_mask : int) -> Vector3:
	_start = camera.project_ray_origin(mouse_position)
	_end = camera.project_position(mouse_position, 1000)
	var prqp : PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(_start, _end, hit_layer_mask)
	prqp.collide_with_areas = true
	_result_raw = _world_space.intersect_ray(prqp)
	
	return _result_raw.get("position") if _result_raw.size() else _end


func get_raycast_results(origin_position : Vector3, end_position : Vector3, hit_layer_mask : int) -> Dictionary:
	var prqp : PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(origin_position, end_position, hit_layer_mask)
	prqp.collide_with_areas = true
	_result_raw = _world_space.intersect_ray(prqp)
	return _result_raw
#
#
#func get_raycast_results(origin_position : Vector3, quat_rotation : Quaternion) -> Vector3:
	## Calculate the end point of the ray
	#_world_space = get_world_3d().direct_space_state
	#_end = origin_position + (quat_rotation * Vector3(0, 0, -1)) * 1000
	#var prqp : PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(origin_position, _end)
	#prqp.collide_with_areas = true
	#result_raw = _world_space.intersect_ray(prqp)
	#if result_raw.size() == 0:
		#return _end
	#else:
		#return result_raw.get("position")


func rotate_quat_towards(a: Quaternion, b: Quaternion, speed_rad : float, delta: float) -> Quaternion:
	var angle_to: float = a.angle_to(b)
	var step = speed_rad * delta
	if angle_to > step:
		return a.slerp(b, step / angle_to)
	else:
		return b


func get_child_of_type(node : Node, type : Variant):
	for child in node.get_children():
		if is_instance_of(child, BatteryComponent):
			return child
		# if child.get_script() == type:
			


func is_instance_ofds(obj:Object, given_class_name:String) -> bool:
	if ClassDB.class_exists(given_class_name):
		# We have a build in class
		return obj.is_class(given_class_name)
	else:
		# We don't have a build in class
		# It must be a script class
		var class_script:Script
		# Assume it is a script path and try to load it
		if ResourceLoader.exists(given_class_name):
			class_script = load(given_class_name) as Script

		if class_script == null:
			# Assume it is a class name and try to find it
			for x in ProjectSettings.get_setting("_global_script_classes"):
				if str(x["class"]) == obj.class_name:
					class_script = load(str(x["path"]))
					break

		if class_script == null:
			# Unknown class
			return false

		# Get the script of the object and try to match it
		var check_script : Variant= obj.get_script()
		while check_script != null:
			if check_script == class_script:
				return true

			check_script = check_script.get_base_script()

		# Match not found
		return false