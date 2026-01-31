extends CharacterBody3D


var SPEED : float = 50.0
const JUMP_VELOCITY = 4.5
const BULLET = preload("res://scenes/bullet.tscn")

var has_bag = false



func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
	
func collect_bag():
	if has_bag:
		return false
	else:
		$bag_001.visible = true
		has_bag = true
		SPEED = 20
		return true
		
	
	
func remove_bag():
	$bag_001.visible = false
	has_bag = false
	SPEED = 50.0
	
	
		
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
		

	


	var input_dir = Input.get_vector("left", "right", "backward", "forward")
	$farmer_rigged.rotate_y(input_dir.x * delta * -10)
	velocity = -$farmer_rigged.basis.z * SPEED * input_dir.y
	move_and_slide()
	if input_dir.y !=0:
		$AnimationPlayer.play("move_hero")
	else :
		$AnimationPlayer.play("idle")
		
		
		
