extends "res://singletons/player_run_data.gd"

static func init_stats(all_null_values: bool = false) -> Dictionary:
	var stats = .init_stats(all_null_values)
	stats.merge({ "stat_void_pearl": 0 })
	
	return stats

static func init_effects() -> Dictionary:
	var effects = .init_effects()
	var stats = init_stats()
	
	effects.merge(stats)
	
	return effects
