class_name LaserBeam
extends Node3D

@export_category("Physical properties")
@export var max_ray_count : int = 12  # Max rays in outermost layer
@export var layer_count : int = 3  # Number of concentric layers
@export var beam_radius : float = 0.5
@export var ray_length : float = 30.0
@export_flags_3d_physics var hit_layer_mask
@export var tick_timer : Timer

@export_category("Beam visuals")
@export var _beam : CSGPolygon3D
@export var _beam_path : Path3D
@export var laser_vertices_count : int = 10

var _start_positions_array : Array[Vector3]
var _tick_damage : float


func init():
	var iters_count : int = 0
	for layer in range(layer_count):
		var current_radius = beam_radius * (layer + 1) / float(layer_count)
		var ray_count = int(max_ray_count * current_radius / beam_radius)
		ray_count = max(ray_count, 1)
		for i in range(ray_count):
			var angle = (i / float(ray_count)) * TAU  # TAU is 2 * PI
			var offset = Vector3(cos(angle), sin(angle), 0) * current_radius
			_start_positions_array[iters_count] = global_position + offset
			iters_count += 1
	
	var beam_points_array : Array
	for i in range(laser_vertices_count):
		var angle = (i / float(10)) * TAU  # TAU is 2 * PI
		var offset = Vector3(cos(angle), sin(angle), 0) * beam_radius
		beam_points_array.append(offset)
	_beam.polygon = beam_points_array
	_beam.visible = false


func change_damage_properties(tick_time : float, tick_damage : float):
	tick_timer.wait_time = tick_time
	_tick_damage = tick_damage


func turn_on_beam():
	_beam.visible = true
	tick_timer.timeout.connect(calculate_beam)
	tick_timer.start()


func turn_off_beam():
	_beam.visible = false
	tick_timer.timeout.disconnect(calculate_beam)
	tick_timer.stop()


func calculate_beam():
	var min_length_2x : float = INF
	var max_length_2x : float = -INF
	#var iters_count : int = 0
	for s_position in _start_positions_array:
		var e_position = s_position + ((get_parent() as LaserPower).gun_entity_ref.quaternion * Vector3.FORWARD) * ray_length
		var results = G_GameHelpers.get_raycast_results(s_position, e_position, hit_layer_mask)
		
		var length_2x : float
		if results.size():
			length_2x = (results.get("position") - s_position).length_squared()
		else:
			length_2x = (e_position - s_position).length_squared()
		
		min_length_2x = length_2x if (min_length_2x > length_2x) else min_length_2x
		max_length_2x = length_2x if (max_length_2x < length_2x) else max_length_2x
	
	_beam_path.curve.set_point_position(1, -Vector3(0, 0, lerpf(sqrt(min_length_2x), sqrt(max_length_2x), 0.5)))
