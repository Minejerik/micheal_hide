extends Node

var _goals_collected = []
var _next_level = "level1"


var _level_unlocks = {
	"WIN31":"level2"
}

# ITEM IDS
# WIN31 - Windows 3.1 box

func collect_goal(item_name):
	if item_name not in _goals_collected:
		_goals_collected.append(item_name)
		if item_name in _level_unlocks.keys():
			_next_level = _level_unlocks[item_name]
		print("collected "+item_name)

func get_next_level():
	return _next_level
