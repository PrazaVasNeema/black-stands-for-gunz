class_name GameShogun
extends Node


@export var world_teikyou : WorldTeikyou
@export var game_state_gameplay : GameStateGameplay

@export var testing_build : GunzBuildData

@export var main_menus_controller : MainMenusController


func _ready() -> void:
	G_CamerasManager.add_camera(GameConstants.CAMERAS.MAIN_VIEW, world_teikyou.camera_main_view)
	G_CamerasManager.add_camera(GameConstants.CAMERAS.OPTIONS_VIEW, world_teikyou.camera_options)
	G_CamerasManager.add_camera(GameConstants.CAMERAS.CABIN_VIEW, world_teikyou.player_teikou.player_main_camera)
	main_menus_controller.i_want_to_change.connect(on_i_want_to_change)
	main_menus_controller.turn_on()

	# if testing_build:
	# 	for i in testing_build.gunz_array.size():
	# 		world_teikyou.player_teikou.equip_gun(testing_build.gunz_array[i], i)
	# game_state_gameplay.init(world_teikyou)


func on_i_want_to_change(me : Node):
	match me:
		main_menus_controller:
			main_menus_controller.turn_off()
