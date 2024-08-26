class_name LaserPower
extends PowerModule

enum States {SLEEPING, DEPLOY, RETRACT, READY, FIRING}

@export var lazer_depl_per_tick : float = 0.1
@export var time_between_ticks : float = 0.1
@export var damage_per_tick : float
@export var activation_timer : Timer
@export var beam : LaserBeam

var current_state : States

func init(battery_component : BatteryComponent):
	super(battery_component)
	current_state = States.DEPLOY
	activation_timer.start()
	activation_timer.timeout.connect(func():
			module_changed_ready_status.emit(GameConstants.GUN_CHECKS.GUN_WISE)
)
	beam.change_damage_properties(time_between_ticks, damage_per_tick)
	beam.init()


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
			if current_state == States.FIRING:
				beam.turn_off_beam()
		States.FIRING:
			beam.turn_on_beam()
		States.RETRACT:
			if current_state == States.FIRING:
				beam.turn_off_beam()
	current_state = new_state
