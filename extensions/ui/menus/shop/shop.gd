extends "res://ui/menus/shop/shop.gd"

onready var _void_pearl_ui_scene = preload("res://mods-unpacked/Sygnano-VoidPearl/extensions/ui/menus/shop/void_pearl_ui.tscn")
onready var _header_container = $Content/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer

var dlc = ProgressData.get_dlc_data("abyssal_terrors")

var _void_pearl_ui_container
var _void_pearl_ui_label

const SOLO_PLAYER_INDEX = 0

func _ready():
	_void_pearl_ui_container = _void_pearl_ui_scene.instance()
	_void_pearl_ui_label = _void_pearl_ui_container.get_node("Label")
	
	_header_container.add_child(_void_pearl_ui_container)
	_header_container.move_child(_void_pearl_ui_container, _header_container.get_node("GoldUI").get_index() + 1)
	
	_update_stats(SOLO_PLAYER_INDEX)
	_get_item_popup(SOLO_PLAYER_INDEX).connect("curse_item", self, "_on_curse_item")

func _update_stats(_player_index: = - 1) -> void :
	._update_stats(_player_index)
	
	if (_player_index == - 1):
		return

	var void_pearl_count = RunData.get_player_effect("stat_void_pearl", _player_index)
	if (void_pearl_count == 0):
		_void_pearl_ui_container.hide()
		return

	_void_pearl_ui_label.text = String(void_pearl_count)
	_void_pearl_ui_container.show()
	
func _on_curse_item(item_data: ItemData, player_index: int):
	var items_container: = _get_gear_container(player_index).items_container

	items_container._elements.remove_element(item_data)
	RunData.remove_item(item_data, player_index)
	
	var cursed_item = dlc.curse_item(item_data, player_index)
	RunData.add_item(cursed_item, player_index)
	items_container._elements.add_element(cursed_item)
	
	RunData.remove_stat("stat_void_pearl", 1, player_index)
	_update_stats(player_index)
