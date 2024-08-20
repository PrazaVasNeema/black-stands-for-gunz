extends Node3D



@export var initial_ui_state : GameConstants.UI_STATES
@export var ui_root : Control

var _ui_state_machine : UIStateMachine





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ui_states_array : Array[UIState]
	for view in ui_root.get_children():
		if view is UIState:
			ui_states_array.append(view)
	_ui_state_machine = UIStateMachine.new()
	_ui_state_machine.init(ui_states_array, initial_ui_state)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
