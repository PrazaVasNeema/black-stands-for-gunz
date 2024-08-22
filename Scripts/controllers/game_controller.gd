class_name GameController
extends Node

@export var world_teikyou : WorldTeikyou
@export var testing_build : GunzBuildData
@export var game_state_machine : GameStateMachine


    

func _ready() -> void:

	G_CamerasManager.add_camera(GameConstants.CAMERAS.MAIN_VIEW, world_teikyou.camera_main_view)
	G_CamerasManager.add_camera(GameConstants.CAMERAS.OPTIONS_VIEW, world_teikyou.camera_options)
	G_CamerasManager.add_camera(GameConstants.CAMERAS.CABIN_VIEW, world_teikyou.player_teikou.player_main_camera)

	G_Armory.player_teikyou = world_teikyou.player_teikou

	for i in testing_build.gunz_array.size():
		G_Armory.equip_gun(0, i)
	
	game_state_machine.init(self)
	



	# main_menus_controller.i_want_to_change.connect(on_i_want_to_change)
	# main_menus_controller.turn_on()



	
	# game_state_gameplay.init(world_teikyou)

	# game_state_gameplay.init(world_teikyou)


# func on_i_want_to_change(me : Node):
# 	match me:
# 		main_menus_controller:
# 			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
# 			main_menus_controller.turn_off()
# 			game_state_gameplay.turn_on()
# 		game_state_gameplay:
# 			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
# 			main_menus_controller.turn_on()
# 			game_state_gameplay.turn_off()
