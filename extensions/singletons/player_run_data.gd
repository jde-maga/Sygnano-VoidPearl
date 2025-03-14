extends "res://singletons/player_run_data.gd"

static func init_stats(all_null_values: bool = false) -> Dictionary:
	var stats = .init_stats(all_null_values)
	var void_pearl_stat = {
		"stat_void_pearl": 0
	}
	
	return Utils.merge_dictionaries(stats, void_pearl_stat)
