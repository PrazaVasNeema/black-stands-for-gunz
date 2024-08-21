extends SubGameState


@export var option_buttons_root : Control
@export var back_button : UI_ChangeStateButton

var _option_buttons_array : Array[OptionButton]


func _ready() -> void:
	for child in option_buttons_root.get_children():
		if child is OptionButton:
			_option_buttons_array.append(child)
			(child as OptionButton).item_selected.connect(on_selection_changed.bind(_option_buttons_array.size() - 1))
	back_button.change_state.connect(call_transition.bind("testing"))
	# back_button.connect("pressed", self, "call_transition")3



func enter():
	super()
	var armory_args = G_Armory.get_armory_data()

	var equiped = armory_args["currently_equiped"] as Dictionary
	var all = armory_args["guns_armory_data_array"] as Array[GunArmoryData]

	for i in range(_option_buttons_array.size()):
		var button = _option_buttons_array[i]
		button.clear()
		button.add_item("None")
		for data in all:
			button.add_item(data.gun_name)
		button.select(equiped[i] + 1)


func on_selection_changed(selection_ind : int, corresponding_slot : int):
	# print(str(selection_ind) + str(corresponding_slot))
	G_Armory.equip_gun(selection_ind - 1, corresponding_slot)