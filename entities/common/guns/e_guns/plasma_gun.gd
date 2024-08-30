class_name PlasmaGun
extends EGun

@export var shoot_points_arr : Array[Marker3D]
@export var damage : float = 10
@export var fire_rate : float = 2
@export var plasma_ball : PackedScene
@export var ready_timer : Timer

var cur_shoot_point_ind : int = 0 :
	set(value):
		cur_shoot_point_ind = value % shoot_points_arr.size()


func _ready() -> void:
	init()


func init() -> void:
	ready_timer.wait_time = 1.0 / fire_rate
	ready_timer.one_shot = true
	should_fire = true


func shoot():
	var ball : PlasmaBall = plasma_ball.instantiate()
	ball.position = shoot_points_arr[cur_shoot_point_ind].global_position
	ball.fly_dir = shoot_points_arr[cur_shoot_point_ind].global_transform.basis.z
	G_GameHelpers.projectiles_holder.add_child(ball)
	cur_shoot_point_ind += 1
