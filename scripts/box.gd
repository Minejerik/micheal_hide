extends RigidBody2D

const xbox_card_scene = preload("res://scenes/items/ITEM_xbox_card.tscn")

var broken = false

func handle_break():
	if not broken:
		$BreakParticles.emitting = true
		broken = true


func _on_break_particles_finished() -> void:
	print(randi()%20)
	if (randi()%20) > 15:
		var xbox_card = xbox_card_scene.instantiate()
		xbox_card.position = position
		get_tree().get_root().add_child(xbox_card)
	queue_free()
