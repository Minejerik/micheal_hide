extends Control


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/home.tscn")


func _on_file_id_pressed(id: int) -> void:
	match id:
		0:
			settings()
		1:
			get_tree().quit()

func settings():
	$Settings.visible = true

func credits():
	$Credits.visible = true
	
func attribution():
	$Attribution.visible = true
	

func _on_about_id_pressed(id: int) -> void:
	match id:
		0:
			credits()
		1:
			attribution()
