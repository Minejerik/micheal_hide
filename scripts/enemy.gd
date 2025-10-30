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
@onready var nav_agent = $NavigationAgent2D

# Used for pursuing, starts it, and is followed
@export var target_names = [""]
# Use for walking, the path it follows
@export var path: Path2D
# Wether the enemy is alerted to a target, such as entering colider
@export var alerted: bool = false

# WALKING -> Following the path set above
# WANDERING -> Wandering around, no set path
# PURSUING -> Target was found, pursue, until target lost

enum State {WALKING, WANDERING, PURSUING}

@export var current_state = State.WALKING
@export var default_state = State.WALKING


# The current node in the path that it should go towards when walking
@export var WALKING_current_node = 0
var WALKING_target_node = null

var speed = 50

func _ready():
	if default_state == State.WALKING:
		WALKING_target_node = path.curve.get_point_position(0)
		init_walking()

func _physics_process(_delta: float) -> void:
	look_at(nav_agent.get_next_path_position())
	if alerted:
		player_in_sight = check_player_visible()
	else:
		current_state = default_state
	
	if player_in_sight:
		current_state = State.PURSUING
	
	match current_state:
		State.WALKING:
			handle_walking()
		State.WANDERING:
			pass
		State.PURSUING:
			handle_pursuing()
			
	move()

func handle_walking():
	look_at(nav_agent.get_next_path_position())

func init_walking():
	WALKING_current_node += 1
	if WALKING_current_node >= path.curve.point_count:
		WALKING_current_node = 0
	WALKING_target_node = path.curve.get_point_position(WALKING_current_node)

func move():
	# All moving, using pathfinding
	var direction = nav_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = direction * speed
	nav_agent.set_velocity(velocity)
		
	#move_and_slide()
	
func _target_reached_nav() -> void:
	if current_state == State.WALKING:
		init_walking()


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

func _on_player_find_timeout_timeout() -> void:
	if current_state == State.PURSUING:
		nav_agent.target_position = player_body.global_position
	elif current_state == State.WALKING:
		nav_agent.target_position = WALKING_target_node
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name in target_names && current_state != State.PURSUING:
		print("Player Entered")
		alerted = true
		player_body = body
		
		
#func _on_area_2d_body_exited(body: Node2D) -> void:


func _on_fire_timer_timeout() -> void:
	if current_state == State.PURSUING && check_player_visible():
		bulletfire.fire_bullet(global_rotation, 150)


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()



func _on_lose_interest_body_exited(body: Node2D) -> void:
	if body.name in target_names && player_body && body.name == player_body.name:
		print("Player Exited")
		alerted = false
		player_in_sight = false
		if default_state == State.WALKING:
			init_walking()
