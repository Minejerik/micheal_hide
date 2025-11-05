extends Node2D

@onready var id_to_obj = {
	"OS31": $item_os31,
	"OS95": $item_os95,
	"OS98": $item_os98,
	"OS2000": $item_os2000
}

func _ready() -> void:
	var goals = DataManager.get_goals_collected()
	for id in DataManager.goal_ids:
		if id not in goals:
			id_to_obj[id].visible = false
			#id_to_obj[id].CollisionObject2D.disable = true	
