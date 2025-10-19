extends RigidBody2D

func handle_break():
	$BreakParticles.emitting = true


func _on_break_particles_finished() -> void:
	queue_free()
