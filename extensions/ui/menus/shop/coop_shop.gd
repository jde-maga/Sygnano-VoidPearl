extends "res://ui/menus/shop/coop_shop.gd"

onready var _coop_void_pearl_ui_scene = preload("res://mods-unpacked/Sygnano-VoidPearl/extensions/ui/menus/shop/coop_void_pearl_ui.tscn")

var dlc = ProgressData.get_dlc_data("abyssal_terrors")

func _ready():
	for player_index in RunData.get_player_count():
		var gold_ui = _get_coop_player_container(player_index).find_node("GoldUI")
		var buttons_container = gold_ui.get_parent()	
		var void_pearl_ui = _coop_void_pearl_ui_scene.instance()
		void_pearl_ui.name = "VoidPearlUI"
		void_pearl_ui.hide()

		buttons_container.add_child(void_pearl_ui)
		buttons_container.move_child(void_pearl_ui, gold_ui.get_index() + 1)
		
		_update_stats(player_index)
		_get_item_popup(player_index).connect("curse_item", self, "_on_curse_item")

func _update_stats(_player_index: = - 1) -> void :
	._update_stats(_player_index)
	
	if (_player_index == -1):
		return

	var void_pearl_count = RunData.get_player_effect("stat_void_pearl", _player_index)		
	var void_pearl_container = _get_coop_player_container(_player_index).find_node("VoidPearlUI", true, false)
	var void_pearl_label = void_pearl_container.get_node("Label")

	if (void_pearl_count <= 0):
		void_pearl_container.hide()
		return

	void_pearl_label.text = String(void_pearl_count)
	void_pearl_container.show()

func _on_curse_item(item_data: ItemData, player_index: int):
	var items_container = _get_gear_container(player_index).items_container

	items_container._elements.remove_element(item_data)
	RunData.remove_item(item_data, player_index)
	
	var cursed_item = dlc.curse_item(item_data, player_index)
	RunData.add_item(cursed_item, player_index)
	items_container._elements.add_element(cursed_item)
	
	RunData.remove_stat("stat_void_pearl", 1, player_index)
	_update_stats(player_index)
