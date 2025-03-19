extends "res://ui/menus/shop/item_popup.gd"

signal curse_item(item_data, player_index)

onready var _buttons_container = $ItemPanelUI/MarginContainer/VBoxContainer

var _curse_button

func _ready():
	if (!_buttons_container or RunData.is_coop_run):
		return
	
	_curse_button = _cancel_button.duplicate()
	_curse_button.name = "CurseButton"
	_curse_button.text = "Curse"
	_curse_button.connect("pressed", self, "_on_CurseButton_pressed")
	_curse_button.hide()

	_buttons_container.add_child(_curse_button)
	_buttons_container.move_child(_curse_button, _buttons_container.get_node("EmptySpace").get_index() + 1)

func _update_button_visibilities() -> void:
	if (RunData.is_coop_run):
		._update_button_visibilities()
		return
	
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

func should_show_buttons(item_data: ItemParentData, focused: bool) -> bool:
	if (
		buttons_enabled
		and (not RunData.is_coop_run or focused)
		and item_data is ItemData
		and not "character" in item_data.my_id
		and not item_data.is_cursed
		and RunData.get_player_effect("stat_void_pearl", player_index) > 0
	):
		return true
	return .should_show_buttons(item_data, focused) 

func _on_CurseButton_pressed() -> void:
	emit_signal("curse_item", _item_data, player_index)
