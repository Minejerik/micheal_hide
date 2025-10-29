extends StaticBody2D

@export var allowed_to_pick_up = false
@export var item_name = ""
@export var isgoal = false

func allow_pick_up():
	return allowed_to_pick_up

func pick_up():
	if isgoal:
		DataManager.collect_goal(item_name)
	else:
		DataManager.collect_item(item_name)
	queue_free()
	return item_name
