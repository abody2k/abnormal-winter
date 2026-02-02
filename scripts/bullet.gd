extends CharacterBody3D


func _physics_process(delta):
	velocity = basis.x * 10
	var target = move_and_collide(velocity)
	if target:
		if target.get_collider().name == "alien":
			target.get_collider().take_damage(5)
		else:
			target.get_collider().queue_free()
		
		queue_free()

func _on_timer_timeout():
	queue_free()
