extends Node2D

const bullet = preload("res://scenes/objects/bullet.tscn")

var temp = 0.0

func fire_bullet():
	var bullet_real = bullet.instantiate()
	bullet_real.fire(temp, 50)
	temp += 3.14
	add_child(bullet_real)
	
	
func _on_timer_timeout() -> void:
	fire_bullet()
	$Timer.start(1)
