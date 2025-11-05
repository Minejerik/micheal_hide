extends CanvasLayer

var texts = []

func _ready() -> void:
	DataManager.goalCollected.connect(handle_goal_collection)
	DataManager.itemCollected.connect(handle_item_collection)
	
	
func send_notification(text):
	var temp_label = $notificationTemplate.duplicate()
	temp_label.show()
	temp_label.set_text(text)
	$notifications.add_child(temp_label)
	texts.append(temp_label)
	temp_label.start_timer()
	
	
func _collect_text(item_name):
	send_notification("Collected "+DataManager.get_item_real_name(item_name)+"!")
	
func handle_goal_collection(goal_collected):
	_collect_text(goal_collected)
	
func handle_item_collection(item_collected):
	_collect_text(item_collected)
