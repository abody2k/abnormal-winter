extends CharacterBody3D


const SPEED = 50.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		move_and_slide()
		$AnimationPlayer.play("idle")
		return
		
	# Handle jump.
	if Input.is_action_just_pressed("fire"):
		#fire a bullet
		pass

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "backward", "forward")
	$farmer_rigged.rotate_y(input_dir.x * delta * 10)
	velocity = -$farmer_rigged.basis.z * SPEED * input_dir.y
	move_and_slide()
	$AnimationPlayer.play("move_hero")
	return
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
