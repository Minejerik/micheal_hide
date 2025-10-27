extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player" && DataManager.target_level:
		get_tree().change_scene_to_file("res://scenes/levels/"+DataManager.target_level+".tscn")
