class_name PlayerController
extends Node


var gunz_shogun : GunzShogun

@onready var _input_shogun : InputShogun = %InputShogun

func _init() -> void:
	gunz_shogun.lock_n_load()
	_input_shogun.mouse_position_changed.connect(deal_with_mouse)
