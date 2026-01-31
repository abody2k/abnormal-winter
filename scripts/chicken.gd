extends CharacterBody3D



enum MODES {IDLE, ATTACKING}


var mode : MODES = MODES.IDLE


var enemies = []


var target : CharacterBody3D = null




@export var SPEED = 20.0
@export var distance = 10.0


const BULLET = preload("res://scenes/bullet.tscn")



func _physics_process(delta):
	match mode:
		MODES.IDLE:
			if target:
				if position.distance_to(target.position) > distance:
					look_at(target.position)
					velocity = -basis.z * SPEED
					move_and_slide()
					$AnimationPlayer.play("chicken_walk")
				else:
					$AnimationPlayer.play("chicken_idle")
					mode = MODES.ATTACKING
		MODES.ATTACKING:
			$AnimationPlayer.play("chicken_attack")


func _on_detector_body_entered(body):
	if enemies.has(body):
		return
		
		
	enemies.append(body)
	body.death.connect(remove_enemy)


func remove_enemy(enemy):
	enemies = enemies.filter(func (e): return enemy != e)
	if enemy == target:
		target = null
		if enemies.is_empty():
			return
		else :
			target = enemies[0]
			
	


func _on_detector_body_exited(body):
	remove_enemy(body)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "chicken_attack":
		var bullet = BULLET.instantiate()
		get_parent().add_child(bullet)
		bullet.position = $aim.global_position
		bullet.rotation = $aim. rotation
