extends Panel

func start_timer():
	$DeleteTimer.start()
	
func set_text(text):
	$notificatiionLabel.text = text

func _on_delete_timer_timeout() -> void:
	queue_free()
