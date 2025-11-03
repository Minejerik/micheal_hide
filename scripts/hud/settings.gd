extends Window

func _ready() -> void:
	self.close_requested.connect(handle_close)
	

func handle_close():
	self.visible = false


func _on_visibility_changed() -> void:
	if self.visible:
		$GridContainer/AudioButton.button_pressed = SettingsManager.Settings["audio"]
		$GridContainer/VolumeSlider.value = SettingsManager.Settings["audio_volume"]


func _on_save_button_pressed() -> void:
	SettingsManager.Settings["audio"] = $GridContainer/AudioButton.button_pressed
	SettingsManager.Settings["audio_volume"] = $GridContainer/VolumeSlider.value
	handle_close()
