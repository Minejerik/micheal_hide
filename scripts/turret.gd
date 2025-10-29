extends CharacterBody2D

# Is the player within the area2d?
var player_in_sight = false
# Body of the player, used to look at
var player_body = null

# The bullet firer
@onready var bulletfire = $BulletFire
@onready var firetimer = $FireTimer

# Used for pursuing, starts it, and is followed
@export var target_names = [""]

func _physics_process(_delta: float) -> void:
	if player_in_sight:
		handle_pursuing()
	
func handle_pursuing():
	var distance_to_player = global_position.distance_to(player_body.global_position)
	if distance_to_player < 100 && firetimer.is_stopped():
		firetimer.start()

func check_player_visible():
	# Checks if the player is not blocked by anything, using a raycast
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, player_body.global_position)
	var result = space_state.intersect_ray(query)
	if result:
		if result.collider == player_body:
			#nav_agent.target_position = player_body.global_position
			return true
	return false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name in target_names:
		print("Player Entered")
		player_body = body

func _on_fire_timer_timeout() -> void:
	if check_player_visible():
		bulletfire.fire_bullet(global_rotation, 150)

func _on_lose_interest_body_exited(body: Node2D) -> void:
	if body.name in target_names && player_body && body.name == player_body.name:
		print("Player Exited")
		player_in_sight = false
