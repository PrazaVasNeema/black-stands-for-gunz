class_name IG_Action
extends SubGameState


func enter() -> void:
	super()
	print("j1")
	G_InputService.pause_pressed.connect(call_transition.bind(GameConstants.SUB_GAME_STATES.IG_PAUSE))
	(core as IG_GameState).gameplaye_player_shogun.turn_on()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func exit():
	super()
	G_InputService.pause_pressed.disconnect(call_transition.bind(GameConstants.SUB_GAME_STATES.IG_PAUSE))
	(core as IG_GameState).gameplaye_player_shogun.turn_off()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func testttt(hehe):
	print("jopa")
	print(str(hehe))