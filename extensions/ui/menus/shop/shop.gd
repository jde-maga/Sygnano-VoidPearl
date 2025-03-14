extends "res://ui/menus/shop/shop.gd"

onready var _void_pearl_ui_scene = preload("res://mods-unpacked/Sygnano-VoidPearl/extensions/ui/menus/shop/void_pearl_ui.tscn")
onready var _header_container = $Content/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer

var _void_pearl_ui_label_container

func _ready():
	._ready()
	
	_void_pearl_ui_scene = _void_pearl_ui_scene.instance()
	_void_pearl_ui_label_container = _void_pearl_ui_scene.get_node("Label")
	#_void_pearl_ui_label_container.text = String(RunData.get_player_effect("stat_void_pearl", _player_index))

	_header_container.add_child(_void_pearl_ui_scene)
	_header_container.move_child(_void_pearl_ui_scene, _header_container.get_node("GoldUI").get_index() + 1)

func _update_stats(_player_index: = - 1) -> void :
	._update_stats(_player_index)

	var _void_pearl_count = RunData.get_player_effect("stat_void_pearl", _player_index)
	_void_pearl_ui_label_container.text = String(_void_pearl_count)
	
	if (_void_pearl_count == 0):
		_void_pearl_ui_scene.hide()
	else:
		_void_pearl_ui_scene.show()
	
