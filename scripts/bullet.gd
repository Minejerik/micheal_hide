extends RigidBody2D



func fire(facing:float, speed:float, pos:Vector2):
	### Handles Firing of the bullet, needs rotation, in radians, and speed
	print("Firing w "+str(rad_to_deg(facing))+" Facing, and "+str(speed))
	global_position = pos
	rotate(facing)
	apply_central_impulse(Vector2(cos(facing), sin(facing))*speed)
	


func _on_death_timer_timeout() -> void:
	queue_free()

func _on_collision_particles_finished() -> void:
	queue_free()


func _on_collision_area_body_entered(body: Node2D) -> void:
		if "box" in body.name:
			body.handle_break()
		if "player" in body.name:
			DataManager.level_loss()
		$Collision_particles.emitting = true
		linear_velocity = Vector2.ZERO
		$Sprite2D.hide()
