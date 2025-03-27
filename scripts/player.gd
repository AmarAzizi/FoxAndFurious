extends CharacterBody2D


const JUMP_VELOCITY = -300.0
signal hit

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		$AnimatedSprite2D.play("run")

	# Handle jump.
	if Input.is_action_just_pressed("click") or Input.is_action_just_pressed("spazio") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")



	move_and_slide()
	var collision = get_last_slide_collision()
	if collision:
		if collision.get_collider() is CharacterBody2D:
			hit.emit()
