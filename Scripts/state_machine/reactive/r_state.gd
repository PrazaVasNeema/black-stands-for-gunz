class_name R_State
extends State

signal transitioned(new_state_name)


func call_transition(new_state_name):
	transitioned.emit(new_state_name)
