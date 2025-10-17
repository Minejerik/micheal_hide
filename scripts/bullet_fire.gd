extends Node2D

const bullet = preload("res://scenes/objects/bullet.tscn")

func fire_bullet(rot, power):
	var bullet_real = bullet.instantiate()
	bullet_real.fire(rot, power, global_position)
	get_tree().root.add_child(bullet_real)
	
#func _on_timer_timeout() -> void:
	#fire_bullet()
	#$Timer.start(1)
