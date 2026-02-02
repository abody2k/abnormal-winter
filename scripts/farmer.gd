extends CharacterBody3D


var SPEED : float = 100.0
const JUMP_VELOCITY = 4.5
const BULLET = preload("res://scenes/bullet.tscn")

var has_bag = false

signal death


var loaded = true

var enemies = []
var target : CharacterBody3D = null

var is_playing = false


func start_game():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	is_playing = true
	
	
func collect_bag():
	if has_bag:
		return false
	else:
		$farmer_rigged/bag_001.visible = true
		has_bag = true
		SPEED = 20
		return true
		
	
	
func remove_bag():
	$farmer_rigged/bag_001.visible = false
	has_bag = false
	SPEED = 50.0
	
	
		
func _physics_process(delta):
	
	if not is_playing:
		return
	# Add the gravity.
	if Input.is_action_just_pressed("assemble"):
		get_tree().call_group("allies","help",self)
	if target:
		$farmer_rigged/Node3D.look_at(target.position)
	if Input.is_action_just_pressed("fire") and loaded:
		var bullet = BULLET.instantiate()
		get_parent().add_child(bullet)
		loaded = false
		$reloader.start()
		bullet.position = $farmer_rigged/Node3D/gun/aim.global_position
		bullet.rotation = $farmer_rigged/Node3D/gun/aim. global_rotation
	
	else:
		pass
		#TODO play a sound for jamming
	var x = Input.get_last_mouse_velocity()
	$arm.rotate_y(x.x * delta * -0.01)
	
	if not is_on_floor():
		velocity = get_gravity() * 20
		move_and_slide()
		return
		

	


	var input_dir = Input.get_vector("left", "right", "backward", "forward")
	$farmer_rigged.rotate_y(input_dir.x * delta * -10)
	velocity = -$farmer_rigged.basis.z * SPEED * input_dir.y
	move_and_slide()
	if input_dir.y !=0:
		$AnimationPlayer.play("move_hero")
	else :
		$AnimationPlayer.play("idle")
		
		
		

func _exit_tree():
	death.emit(self)
	get_tree().reload_current_scene()

func sorting():
	var new_arr = []
	for  i in range(enemies.size()):
		for j in range(enemies.size()):
			if j +1 < enemies.size():
				if position.distance_to(enemies[j].position) < position.distance_to(enemies[i].position):
					var temp = enemies[j]
					enemies[j] = enemies[j+1]
					enemies[j+1] = temp
					
		
		
func _on_area_3d_body_entered(body):

		
	if enemies.has(target):
		return

	if !body.is_connected("death",remove_enemy):
		
		body.death.connect(remove_enemy)
		
	enemies.append(body)
	sorting()
	if !target:
		target = body
		



func remove_enemy(enemy):
	enemies = enemies.filter(func (e): return enemy != e)
	if enemy == target:
		target = null
		if enemies.is_empty():
			return
		else :
			target = enemies[0]

func _on_area_3d_body_exited(body):
	remove_enemy(body)


func _on_reloader_timeout():
	loaded = true
	pass # Replace with function body.
