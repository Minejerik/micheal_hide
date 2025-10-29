extends StaticBody2D

const screen_scene = preload("res://scenes/computer_screen.tscn")
@export var usable = true

var player_in_range = false

func _on_use_area_body_entered(body: Node2D) -> void:
	if body.name == "player" && usable:
		player_in_range = true

func _on_use_area_body_exited(body: Node2D) -> void:
	if body.name == "player" && usable:
		player_in_range = false
		
func _input(event: InputEvent) -> void:
	if usable:
		if event.is_action("interact") && player_in_range && not DataManager.computer_screen_open:
			var screen = screen_scene.instantiate()
			DataManager.computer_screen_open = true
			get_tree().root.add_child(screen)
		
		
