extends Node

signal goalCollected(goal_name)
signal itemCollected(item_name)

var _goals_collected = []
var _temp_goal_collected = ""
var _goal_collected_this_level = false
var _next_level = "level1"
var computer_screen_open = false
var target_level = null

var levels = [
	"level1",
	"level2",
	"level3",
	"level4"
]

var levels_unlocked = [
	"level1"
]

var _level_unlocks = {
	"OS31":"level2",
	"OS95":"level3",
}

var level_info = {
	"level1": {"name": "Level 1", "desc": "Find Michealsoft OS 3.1"},
	"level2": {"name": "Level 2", "desc": "Find Michealsoft OS 95"},
	"level3": {"name": "Level 3", "desc": "Find Michealsoft OS 3.1"},
	"level4": {"name": "Level 4", "desc": "Find Michealsoft OS 3.1"},
}

var goal_ids = [
	"OS31",
	"OS95",
	"OS98",
	"OS2000"
]

var _item_real_names = {
	"OS31": "Michealsoft OS 3.1",
	"OS95": "Michealsoft OS 95",
	"OS98": "Michealsoft OS 98",
	"OS2000": "Michealsoft OS 2000",
	"XBOXCARD": "Xbox gift card"
}

# ITEM IDS
# OS31 - OS 3.1

func collect_goal(item_name):
	if item_name not in _goals_collected:
		_goal_collected_this_level = true
		_temp_goal_collected = item_name
		goalCollected.emit(item_name)

func level_win():
	if _goal_collected_this_level:
		_goals_collected.append(_temp_goal_collected)
		if _temp_goal_collected in _level_unlocks.keys():
			_next_level = _level_unlocks[_temp_goal_collected]
			levels_unlocked.append(_next_level)

func level_loss():
	reset_level()
	get_tree().change_scene_to_file("res://scenes/levels/"+target_level+".tscn")

func reset_level():
	_temp_goal_collected = ""
	_goal_collected_this_level = false

func collect_item(item_name):
	itemCollected.emit(item_name)
	print("item collected "+item_name)

func get_goals_collected():
	return _goals_collected
	
func get_item_real_name(id):
	return _item_real_names[id]

func get_next_level():
	return _next_level
