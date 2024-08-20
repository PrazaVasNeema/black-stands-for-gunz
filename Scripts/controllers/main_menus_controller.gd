class_name MainMenusController
extends hghgfh


@export var initial_ui_state : GameConstants.UI_STATES
@export var ui_root : Control

var _ui_state_machine : UIStateMachine


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ui_states_array : Array[UIState]
	for view in ui_root.get_children():
		if view is UIState:
			(view as UIState).init(self)
			ui_states_array.append(view)
	_ui_state_machine = UIStateMachine.new()
	_ui_state_machine.init(ui_states_array)


func turn_on():
	super()
	ui_root.visible = true
	_ui_state_machine.on_change_state(initial_ui_state)


func turn_off():
	super()
	ui_root.visible = false
