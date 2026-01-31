extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta):
	velocity = basis.z * -200 
	var target = move_and_collide(velocity)
	if target:
		target.get_collider().queue_free()
		queue_free()

func _on_timer_timeout():
	queue_free()
