extends CharacterBody2D

## Speed in pixels per second.
@export_range(0, 1000) var speed := 60

func _physics_process(_delta: float) -> void:
	get_player_input()
	if move_and_slide():
		handle_collisions()
	
func handle_collisions():
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		if "item" in str(collision.get_collider().name).to_lower():
			if collision.get_collider().allow_pick_up():
				collision.get_collider().pick_up()
		else:
			var body := collision.get_collider() as RigidBody2D
			if body:
				body.apply_central_force(-150.0 * collision.get_normal())
	
func get_player_input() -> void:
	var vector := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if not DataManager.computer_screen_open:
		look_at(get_global_mouse_position())
		velocity = vector * speed
	else:
		velocity = Vector2.ZERO
