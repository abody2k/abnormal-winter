extends CharacterBody3D


const SPEED = 50.0
const JUMP_VELOCITY = 4.5
const BULLET = preload("res://scenes/bullet.tscn")


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
	
func collect_bag():
	
	$bag_001.visible = true
	
func _physics_process(delta):
	# Add the gravity.
	if Input.is_action_just_pressed("fire"):
		var bullet = BULLET.instantiate()
		get_parent().add_child(bullet)
		bullet.position = $farmer_rigged/gun/aim.global_position
		bullet.rotation = $farmer_rigged/gun/aim. global_rotation
		
	var x = Input.get_last_mouse_velocity()
	$arm.rotate_y(x.x * delta * -0.01)
	if not is_on_floor():
		velocity += get_gravity() * delta
		move_and_slide()
		$AnimationPlayer.play("idle")
		return
		
	# Handle jump.
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "backward", "forward")
	$farmer_rigged.rotate_y(input_dir.x * delta * -10)
	velocity = -$farmer_rigged.basis.z * SPEED * input_dir.y
	move_and_slide()
	if input_dir.y !=0:
		$AnimationPlayer.play("move_hero")
	else :
		$AnimationPlayer.play("idle")
		
		
		
