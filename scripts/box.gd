extends RigidBody2D

const xbox_card_scene = preload("res://scenes/items/ITEM_xbox_card.tscn")

var broken = false
var by_player = false

func handle_break(player_break):
	if not broken:
		by_player = player_break
		$BreakParticles.emitting = true
		broken = true
		$Sprite2D.visible = false
		$CollisionShape2D.disabled = true
		$LightOccluder2D.visible = false


func _on_break_particles_finished() -> void:
	if not by_player:
		if (randi()%20) > 15:
			var xbox_card = xbox_card_scene.instantiate()
			xbox_card.position = position
			get_tree().get_root().add_child(xbox_card)
	else:
		if (randi()%100) > 90:
			var xbox_card = xbox_card_scene.instantiate()
			xbox_card.position = position
			get_tree().get_root().add_child(xbox_card)
	queue_free()
