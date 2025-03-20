extends CharacterBody2D



func _physics_process(delta: float) -> void:
	velocity.x = -Global.scroll_speed

	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
