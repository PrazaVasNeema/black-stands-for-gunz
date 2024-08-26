class_name PowerModule
extends Node

signal module_changed_ready_status(new_status)

var battery_component_ref : BatteryComponent
var should_fire : bool
var should_retract : bool
var gun_entity_ref : GunEntity


func init(battery_component : BatteryComponent, gun_entity : GunEntity):
	battery_component_ref = battery_component
	gun_entity_ref = gun_entity
