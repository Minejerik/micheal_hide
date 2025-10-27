extends CanvasLayer

var button_group

var open_level = null

func _ready() -> void:
	DataManager.target_level = open_level
	for level in DataManager.levels:
		var temp_label = $ButtonTemplate.duplicate()
		temp_label.show()
		if not level in DataManager.levels_unlocked:
			temp_label.disabled = true
		temp_label.set_meta("level_name", level)
		temp_label.text = DataManager.level_info[level]["name"]
		$Panel/VBoxContainer/HSplitContainer/ScrollContainer/ButtonContainer.add_child(temp_label)
		
	button_group = $ButtonTemplate.button_group
	button_group.connect("pressed", _change_text_button_press)

func _on_close_button_pressed() -> void:
	DataManager.computer_screen_open = false
	queue_free()

func _change_text_button_press(button):
	var level = button.get_meta("level_name")
	open_level = level
	$Panel/VBoxContainer/HSplitContainer/Control/VBoxContainer/levelText.text = DataManager.level_info[level]["name"]
	$Panel/VBoxContainer/HSplitContainer/Control/VBoxContainer/Desc.text = DataManager.level_info[level]["desc"]

func _on_set_button_pressed() -> void:
	DataManager.target_level = open_level
