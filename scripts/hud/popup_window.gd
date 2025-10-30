extends Window


func _ready() -> void:
	self.close_requested.connect(handle_close)
	
func handle_close():
	self.visible = false
