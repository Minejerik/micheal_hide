extends Node2D

@onready var id_to_obj = {
	"WIN31": $item_win31
}

func _ready() -> void:
	var goals = DataManager.get_goals_collected()
	for id in DataManager.goal_ids:
		if id not in goals:
			id_to_obj[id].visible = false
			#id_to_obj[id].CollisionObject2D.disable = true	
