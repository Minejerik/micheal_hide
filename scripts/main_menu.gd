extends Control


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/home.tscn")


func _on_file_id_pressed(id: int) -> void:
	print(id)
	match id:
		0:
			get_tree().quit()

func credits():
	# Show Credits
	pass
	
func attribution():
	# Show Attribution
	pass
	

func _on_about_id_pressed(id: int) -> void:
	match id:
		0:
			credits()
		1:
			attribution()
