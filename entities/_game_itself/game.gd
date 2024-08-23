class_name Game
extends Node

@export var game_state_machine : GameStateMachine
@export var world_provider : WorldProvider


func _ready() -> void:
	G_CamerasManager.add_camera(GameConstants.CAMERAS.MAIN_VIEW, world_provider.camera_main_view)
	G_CamerasManager.add_camera(GameConstants.CAMERAS.OPTIONS_VIEW, world_provider.camera_options)
	G_CamerasManager.add_camera(GameConstants.CAMERAS.CABIN_VIEW, world_provider.player_provider.player_main_camera)
	G_CamerasManager.add_camera(GameConstants.CAMERAS.HOW_TO_PLAY_VIEW, world_provider.camera_how_to_play)

	game_state_machine.init(self)
