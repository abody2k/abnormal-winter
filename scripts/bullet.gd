extends CharacterBody3D


func _physics_process(delta):
	velocity = basis.x * 2 
	var target = move_and_collide(velocity)
	if target:
		target.get_collider().queue_free()
		queue_free()

func _on_timer_timeout():
	queue_free()
