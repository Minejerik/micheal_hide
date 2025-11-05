extends Window


func _ready() -> void:
	self.close_requested.connect(handle_close)
	
func handle_close():
	self.visible = false
	get_tree().paused = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("ui_cancel"):
		self.visible = true
		get_tree().paused = true
