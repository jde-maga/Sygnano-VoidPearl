extends "res://ui/menus/shop/coop_item_popup.gd"

func _ready():
	var buttons_container = _cancel_button.get_parent()

	var _curse_button = _cancel_button.duplicate()
	_curse_button.name = "CurseButton"
	_curse_button.text = "Curse"
	_curse_button.connect("pressed", self, "_on_CurseButton_pressed")
	_curse_button.hide()

	buttons_container.add_child(_curse_button)
	buttons_container.move_child(_curse_button, _cancel_button.get_index() - 1)

func _update_button_visibilities() -> void:
	var _curse_button = _cancel_button.get_parent().get_node("CurseButton")
	var buttons := [_combine_button, _discard_button, _cancel_button, _curse_button]
	if _item_data is WeaponData:
		_curse_button.hide()
		._update_button_visibilities()
		return
		
	if _item_data == null or not should_show_buttons(_item_data, _focused):
		for button in buttons:
			if button != null:
				button.hide()
				button.focus_mode = FOCUS_NONE
		return
		
	_discard_button.hide()
	_cancel_button.show()
	_cancel_button.focus_mode = FOCUS_ALL if _focused else FOCUS_NONE
	_cancel_button.set_focus_neighbour(1, _curse_button.get_path())
	_curse_button.show()
	_curse_button.focus_mode = FOCUS_ALL if _focused else FOCUS_NONE
	_curse_button.set_focus_neighbour(3, _cancel_button.get_path())
