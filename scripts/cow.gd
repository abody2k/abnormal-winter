extends CharacterBody3D



enum MODES {IDLE, ATTACKING}


var mode : MODES = MODES.IDLE


var enemies = []


var target : CharacterBody3D = null




@export var SPEED = 20.0
@export var distance = 10.0


const BULLET = preload("res://scenes/bomb.tscn")



func _physics_process(delta):
	match mode:
		MODES.IDLE:
			if target:
				if position.distance_to(target.position) > distance:
					look_at(target.position)
					velocity = -basis.z * SPEED
					move_and_slide()
					$AnimationPlayer.play("cow_walking")
				else:
					$AnimationPlayer.play("cow_idle")
					mode = MODES.ATTACKING
			else:
				if !enemies.is_empty():
					target = enemies[0]
				#look_at(Vector3( cos(delta) * 30, position.y, sin(delta) * 30))
				#velocity = Vector3( cos(delta) * 30, -10, sin(delta) * 30)
				#$AnimationPlayer.play("chicken_walk")
				#move_and_slide()
		MODES.ATTACKING:
			$AnimationPlayer.play("cow_attacking")

func _on_detector_body_entered(body):
	if enemies.has(body):
		return
		
		
	enemies.append(body)
	body.death.connect(remove_enemy)


func remove_enemy(enemy):
	enemies = enemies.filter(func (e): return enemy != e)
	if enemy == target:
		target = null
		mode = MODES.IDLE
		if enemies.is_empty():
			return
		else :
			target = enemies[0]
		
			
	


func _on_detector_body_exited(body):
	remove_enemy(body)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "cow_attacking":
		var bullet = BULLET.instantiate()
		if !target: 
			return
		bullet.target=target.position
		get_parent().add_child(bullet)
		bullet.position = $aim.global_position
		bullet.rotation = $aim.global_rotation
		bullet.compute_xz()
