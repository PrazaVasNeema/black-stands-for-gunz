extends SubGameState

@export var exit_button : Button


func _ready() -> void:
	exit_button.pressed.connect(_exit_game)


func _exit_game():
	core.call_transition(GameConstants.GAME_STATES.MAIN_MENUS)
