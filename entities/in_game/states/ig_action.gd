extends SubGameState


func enter() -> void:
	super()
	G_InputService.pause_pressed.connect(call_transition.bind(GameConstants.SUB_GAME_STATES.IG_PAUSE))
	G_InputService.show_mouse(false)
	G_CamerasManager.set_current(GameConstants.CAMERAS.CABIN_VIEW)
	(core as InGame).player_entity.enable()


func exit():
	super()
	G_InputService.pause_pressed.disconnect(call_transition.bind(GameConstants.SUB_GAME_STATES.IG_PAUSE))
	G_InputService.show_mouse(true)
	(core as InGame).player_entity.disable()
