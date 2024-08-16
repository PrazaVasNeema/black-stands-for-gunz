class_name LaserBeamBuhin
extends Node3D


const VisualizerScene = preload("res://scenes/_system/visualizer.tscn")

@export var beam_radius : float = 0.5
@export var ray_count : int = 10  # Number of rays across the beam's width
@export var ray_length : float = 30.0
@export var testing_visualizer : MeshInstance3D
@export var _tick_timer : Timer
@export_flags_3d_physics var test_col
@export var _beam_mesh : MeshInstance3D

@export var _beam : CSGPolygon3D
@export var _beam_path : Path3D


var _space_state : PhysicsDirectSpaceState3D
var _visualizers_array : Array[Node3D]


func lock_n_load():
	for i in range(100):
		var instance = VisualizerScene.instantiate()
		add_child(instance)
		_visualizers_array.append(instance)
	# _tick_timer.wait_time = time_to_tick
	_tick_timer.stop()
	var beam_points_array : Array
	for i in range(10):
		var angle = (i / float(10)) * TAU  # TAU is 2 * PI
		var offset = Vector3(cos(angle), sin(angle), 0) * beam_radius
		beam_points_array.append(offset)
	_beam.polygon = beam_points_array




func turn_on_beam():
	testing_visualizer.visible = true
	_tick_timer.timeout.connect(calculate_beam)
	_tick_timer.start()


func turn_off_beam():
	testing_visualizer.visible = false
	_tick_timer.timeout.disconnect(calculate_beam)
	_tick_timer.stop()

@export var max_ray_count : int = 12  # Max rays in outermost layer
@export var layer_count : int = 3  # Number of concentric layers

func calculate_beam():

	var min_length_2x : float = INF
	var max_length_2x : float = -INF
	# _beam_path.curve.clear_points()
	# _beam_path.curve.add_point(Vector3(10,10,10))
	# _beam_mesh.mesh.height = 100
	print(str(Time.get_datetime_dict_from_system().second) +  "dfgdgf")
	_space_state = get_world_3d().direct_space_state
	var gg : int = 0
	for layer in range(layer_count):
		var current_radius = beam_radius * (layer + 1) / float(layer_count)
		var ray_count = int(max_ray_count * current_radius / beam_radius)  # Fewer rays for smaller layers
		ray_count = max(ray_count, 1)  # Ensure at least one ray per layer
		for i in range(ray_count):


			var angle = (i / float(ray_count)) * TAU  # TAU is 2 * PI
			var offset = Vector3(cos(angle), sin(angle), 0) * current_radius

			var start_position = global_position + offset
			var end_position = start_position - Vector3(0, 0, 1) * ray_length

			var _end = start_position + ((get_parent() as Node3D).quaternion * Vector3(0, 0, -1)) * ray_length

			var result = _space_state.intersect_ray(PhysicsRayQueryParameters3D.create(start_position, _end, test_col))
			if i == 0:
				# print(str(start_position) + " " + str(_end))
				print(result)
			var length_2x : float
			if result:
				var hit_position = result.position
				_draw_laser_segment(start_position, hit_position, gg)
				length_2x = (hit_position - start_position).length_squared()
				
			else:
				_draw_laser_segment(start_position, _end, gg)
				length_2x = (_end - start_position).length_squared()
			gg += 1

			if max_length_2x < length_2x:
				max_length_2x = length_2x
			if min_length_2x > length_2x:
				min_length_2x = length_2x
	
	_beam_path.curve.set_point_position(1, -Vector3(0, 0, lerpf(sqrt(min_length_2x), sqrt(max_length_2x), 0.5)))




func _draw_laser_segment(start, end, index):
	_visualizers_array[index].global_position = end
