extends Node

const AUTHORNAME_MODNAME_DIR := "Sygnano-VoidPearl"
const AUTHORNAME_MODNAME_LOG_NAME := "Sygnano-VoidPearl:Main"

var mod_dir_path := ""
var extensions_dir_path := ""
var translations_dir_path := ""

var _void_pearl_item = preload("res://mods-unpacked/Sygnano-VoidPearl/extensions/items/all/void_pearl/void_pearl_data.tres")

# Before v6.1.0
# func _init(modLoader = ModLoader) -> void:
func _init() -> void:
	mod_dir_path = ModLoaderMod.get_unpacked_dir().plus_file(AUTHORNAME_MODNAME_DIR)
	install_script_extensions()
	add_translations()

func install_script_extensions() -> void:
	extensions_dir_path = mod_dir_path.plus_file("extensions")
	
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file('singletons/player_run_data.gd'))
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file('ui/menus/shop/shop.gd'))


func add_translations() -> void:
	translations_dir_path = mod_dir_path.plus_file("translations")
	
	ModLoaderMod.add_translation(translations_dir_path.plus_file('item_void_pearl.en.translation'))

func _ready() -> void:
	ItemService.add_mod_item(_void_pearl_item)
	ModLoaderLog.info("Ready!", AUTHORNAME_MODNAME_LOG_NAME)
