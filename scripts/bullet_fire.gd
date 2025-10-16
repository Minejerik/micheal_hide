extends Node2D

const bullet = preload("res://scenes/objects/bullet.tscn")

func fire_bullet():
	var bullet_real = bullet.instantiate()
	add_child(bullet_real)
	
	
func _on_timer_timeout() -> void:
	fire_bullet()
	$Timer.start(1)
