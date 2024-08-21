class_name IngameController
extends GameStateController


@export var gameplaye_player_shogun : GameplayPlayerShogun


func init(world_teikyou : WorldTeikyou) -> void:
	gameplaye_player_shogun.lock_n_load(world_teikyou.player_teikou)


func turn_on():
	super()
	G_CamerasManager.set_current(GameConstants.CAMERAS.CABIN_VIEW)
	gameplaye_player_shogun.turn_on()


func turn_off():
	super()
	gameplaye_player_shogun.turn_off()