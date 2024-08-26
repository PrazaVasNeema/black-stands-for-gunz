class_name LaserPower
extends PowerModule

enum States {SLEEPING, DEPLOY, RETRACT, READY, FIRING}

@export var lazer_depl_per_tick : float = 0.1
@export var time_between_ticks : float = 0.1
@export var tick_timer : Timer
@export var activation_timer : Timer

var current_state : States

func init(battery_component : BatteryComponent):
	super(battery_component)
	current_state = States.DEPLOY
	activation_timer.start()
	activation_timer.timeout.connect(func():
			module_changed_ready_status.emit(GameConstants.GUN_CHECKS.GUN_WISE)
)


func _process(delta: float) -> void:
	match current_state:
		States.DEPLOY:
			if activation_timer.time_left == 0.0:
				_set_state(States.READY)
		States.READY:
			if should_retract:
				_set_state(States.RETRACT)
			if should_fire:
				_set_state(States.FIRING)
		States.FIRING:
			if should_retract:
				_set_state(States.RETRACT)
			if !should_fire:
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
