extends Node2D

@export var shown = false
@export var to_show = ""

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" && !shown:
		$"../Hud".send_notification(to_show)
		shown = true
