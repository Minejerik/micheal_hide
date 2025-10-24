extends Label

func start_timer():
	$DeleteTimer.start()
	
func _on_delete_timer_timeout() -> void:
	queue_free()
