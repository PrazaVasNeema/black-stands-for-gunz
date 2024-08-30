class_name PlasmaGun
extends EGun

@export var shoot_points_arr : Array[Marker3D]
@export var damage : float = 10
@export var fire_rate : float = 2
@export var plasma_ball : PackedScene
@export var ready_timer : Timer

var hsm : LimboHSM
var cur_shoot_point_ind : int = 0 :
	set(value):
		cur_shoot_point_ind = value % shoot_points_arr.size()


func _ready() -> void:
	init()


func init() -> void:
	hsm = LimboHSM.new()
	add_child(hsm)
	ready_timer.wait_time = 1.0 / fire_rate
	ready_timer.one_shot = true
	
	var ready_state := LimboState.new().named("ready") \
        .call_on_update(_ready_update)
	var fire_state := LimboState.new().named("fire") \
		.call_on_enter(_fire_start)
	var get_ready_state := LimboState.new().named("get_ready") \
		.call_on_enter(_get_ready_start) \
		.call_on_update(_get_ready_update)
	
	hsm.add_child(ready_state)
	hsm.add_child(fire_state)
	hsm.add_child(get_ready_state)

	hsm.add_transition(ready_state, fire_state, &"fire_started")
	hsm.add_transition(fire_state, get_ready_state, &"fire_ended")
	hsm.add_transition(get_ready_state, ready_state, &"ready")

	hsm.initialize(self)
	hsm.set_active(true)

	# should_fire = true

	# print (str(shoot_points_arr[cur_shoot_point_ind].global_transform.basis.z))



func _ready_update(delta : float) -> void:

	if should_fire:
		hsm.dispatch(&"fire_started")

func _fire_start():
	shoot()
	hsm.dispatch(&"fire_ended")

func _get_ready_start():
	ready_timer.start()
func _get_ready_update(delta : float) -> void:
	if ready_timer.is_stopped():
		hsm.dispatch(&"ready")


func shoot():
	var ball : PlasmaBall = plasma_ball.instantiate()
	ball.position = shoot_points_arr[cur_shoot_point_ind].global_position
	ball.fly_dir = shoot_points_arr[cur_shoot_point_ind].global_transform.basis.z
	G_GameHelpers.projectiles_holder.add_child(ball)
	cur_shoot_point_ind += 1
