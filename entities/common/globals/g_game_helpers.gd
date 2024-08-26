extends Node3D

var _world_space : PhysicsDirectSpaceState3D
var _start : Vector3
var _end : Vector3
var _result_raw : Dictionary


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
