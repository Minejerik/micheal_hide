extends RigidBody2D



func fire(facing:float, speed:float):
	### Handles Firing of the bullet, needs rotation, in radians, and speed
	print("Firing w "+str(facing)+" Facing, and "+str(speed))
	rotate(facing)
	apply_central_force(Vector2(facing, speed))
	


func _on_death_timer_timeout() -> void:
	queue_free()


func _on_body_entered(_body: Node) -> void:
	$Collision_particles.emitting = true
	linear_velocity = Vector2.ZERO
	$Sprite2D.hide()


func _on_collision_particles_finished() -> void:
	queue_free()
