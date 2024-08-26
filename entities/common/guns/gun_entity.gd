class_name GunEntity
extends Node3D

signal gun_finished

const ALL_CONDITIONS_MASK = 0b1111

@export var targeting_component : TargetingComponent
@export var battery_component : BatteryComponent
@export var power_module : PowerModule


var conditions = 0b0010 :
	set(value):
		conditions = value
		targeting_component._update_tween_activity(is_ready)

var is_ready : bool :
	get:
		return (conditions & ALL_CONDITIONS_MASK) == ALL_CONDITIONS_MASK


func init():
	battery_component.cur_energy = battery_component.max_energy
	conditions |= GameConstants.GUN_CHECKS.ENERGY_WISE
	battery_component.depleted.connect(func() :
		conditions &= ~GameConstants.GUN_CHECKS.ENERGY_WISE
		gun_finished.emit()
		)
	power_module.module_changed_ready_status.connect(func(flag) :
		if flag:
			conditions |= GameConstants.GUN_CHECKS.GUN_WISE
		else:
			conditions &= ~GameConstants.GUN_CHECKS.GUN_WISE
		)
	power_module.init(battery_component, self)


func deinit():
	power_module.should_retract = true
	conditions &= ~GameConstants.GUN_CHECKS.DRUM_WISE


func update_targeting(new_ws_position : Vector3):
	if is_ready:
		targeting_component.update_targeting(new_ws_position, self)


func set_should_fire(flag : bool):
	if flag && is_ready:
		power_module.should_fire = true
	else:
		power_module.should_fire = false
