extends CanvasLayer


func _on_close_button_pressed() -> void:
	DataManager.computer_screen_open = false
	queue_free()
