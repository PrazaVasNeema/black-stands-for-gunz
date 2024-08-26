class_name PowerModule
extends Node

signal module_changed_ready_status(new_status)

var battery_component_ref : BatteryComponent
var should_fire : bool
var should_retract : bool

func init(battery_component : BatteryComponent):
	battery_component_ref = battery_component
