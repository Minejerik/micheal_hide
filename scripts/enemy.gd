extends CharacterBody2D

# Is the player within the area2d?
var player_in_sight = false
# Makes sure that the player can be hit by a ray, meaning not behind a wall, etc
var player_ray_cast_check = false
# Body of the player, used to look at
var player_body = null

# The bullet firer
@onready var bulletfire = $BulletFire
@onready var firetimer = $FireTimer

func _physics_process(_delta: float) -> void:
	if player_in_sight:
		if player_ray_cast_check:
			var distance_to_player = global_position.distance_to(player_body.global_position)
			look_at(player_body.position)
			if distance_to_player < 100 && firetimer.is_stopped():
				firetimer.start()
		else:
			var space_state = get_world_2d().direct_space_state
			var query = PhysicsRayQueryParameters2D.create(global_position, player_body.global_position)
			var result = space_state.intersect_ray(query)
			if result:
				if result.collider.name == "player":
					player_ray_cast_check = true
					



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("Player Entered")
		player_in_sight = true
		player_ray_cast_check = false
		player_body = body
		
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		print("Player Exited")
		player_in_sight = false
		player_ray_cast_check = false
		player_body = null


func _on_fire_timer_timeout() -> void:
	if player_in_sight && player_ray_cast_check:
		#global_position.angle_to(player_body.global_position)
		bulletfire.fire_bullet(global_rotation, 150)
