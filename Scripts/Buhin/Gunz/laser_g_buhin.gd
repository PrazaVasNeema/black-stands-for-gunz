extends GunKiso


@export var lazer_max_energy : float = 100
@export var lazer_depl_speed : float = 20
@export var lazer_rec_speed : float = 30
@export var lazer_start_rec_delay : float = 1
@export var _laser_beam_buhin : LaserBeamBuhin
@export var _change_e_lvl_timer : Timer
@export var lazer_change_e_lvl_tick_time : float = 0.1
@export var lazer_min_energy_to_fire : float = 30

var _lazer_cur_energy : float
var _is_able_to_regen_energy : bool = true

func lock_n_load(this_gun_num : int):
	super(this_gun_num)
	_laser_beam_buhin.lock_n_load()
	_lazer_cur_energy = lazer_max_energy
	_change_e_lvl_timer.wait_time = lazer_change_e_lvl_tick_time
	_change_e_lvl_timer.timeout.connect(_update_energy_lvl)


func _process(delta: float) -> void:
	match _current_state:
		States.READY:
			if _firing_input_pressed:
				_set_state(States.FIRING)
		States.FIRING:
			if _lazer_cur_energy == 0 || not _firing_input_pressed:
				_set_state(States.RELOADING)
		States.RELOADING:
			if _lazer_cur_energy >= lazer_min_energy_to_fire:
				_set_state(States.READY)


func _set_state(new_state : States):
	match new_state:
		States.READY:
			print("READY")
		States.FIRING:
			_laser_beam_buhin.turn_on_beam()
			_is_able_to_regen_energy = false
		States.RELOADING:
			_laser_beam_buhin.turn_off_beam()
			get_tree().create_timer(lazer_start_rec_delay).timeout.connect(func():
				_is_able_to_regen_energy = true
			)
	_current_state = new_state


func _update_energy_lvl():
	var change_value : float = 0
	if _current_state == States.FIRING:
		change_value = -lazer_depl_speed * lazer_change_e_lvl_tick_time
	elif _is_able_to_regen_energy:
		change_value = lazer_rec_speed * lazer_change_e_lvl_tick_time
	_lazer_cur_energy = clamp(_lazer_cur_energy + change_value, 0, lazer_max_energy)
