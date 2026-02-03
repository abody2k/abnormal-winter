extends CharacterBody3D



enum MODES {IDLE, ATTACKING, HELP, ATTACK_ALIEN}


var mode : MODES = MODES.IDLE


var enemies = []


var target : CharacterBody3D = null

signal death

var master : CharacterBody3D


@export var SPEED = 20.0
@export var distance = 100.0


const BULLET = preload("res://scenes/bullet.tscn")



var alien : CharacterBody3D = null

func _ready():
	
	alien = get_tree().get_first_node_in_group("alien")

func _physics_process(delta):
	match mode:
		MODES.IDLE:
			if target:
				if position.distance_to(target.position) > distance:
					look_at(target.position)
					velocity = (-basis.z + Vector3.DOWN * 1) * SPEED 
					move_and_slide()
					$AnimationPlayer.play("chicken_walk")
				else:
					$AnimationPlayer.play("chicken_idle")
					mode = MODES.ATTACKING
			else:

				if !enemies.is_empty():
					target = enemies[0]
				if master:
					mode = MODES.HELP
					

		MODES.ATTACKING:
			look_at(target.position)
			$AnimationPlayer.play("chicken_attack")
		MODES.HELP:
					if !master:
						mode= MODES.IDLE
						return
					if position.distance_to(Vector3(master.position.x,position.y,master.position.z))> 20:
						
						look_at(Vector3(master.position.x,position.y,master.position.z))
						velocity = (-basis.z + Vector3.DOWN * 1) * SPEED 
						move_and_slide()
						$AnimationPlayer.play("chicken_walk")
					else:
						$AnimationPlayer.play("chicken_idle")
		MODES.ATTACK_ALIEN:
					if !alien:
						mode= MODES.IDLE
						return
					if position.distance_to(Vector3(alien.position.x,position.y,alien.position.z))> 20:
						
						look_at(Vector3(alien.position.x,position.y,alien.position.z))
						velocity = (-basis.z + Vector3.DOWN * 1) * SPEED 
						move_and_slide()
						$AnimationPlayer.play("cow_walking")
					else:
						target = alien
						mode = MODES.ATTACKING						
func _on_detector_body_entered(body):

	if enemies.has(body):
		return
		
		
	enemies.append(body)
	body.death.connect(remove_enemy)
	if mode != MODES.ATTACK_ALIEN:
		mode = MODES.IDLE

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
	pass
	#remove_enemy(body)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "chicken_attack":
		var bullet = BULLET.instantiate()
		get_parent().add_child(bullet)
		bullet.position = $aim.global_position
		bullet.rotation = $aim.global_rotation



func _exit_tree():
	death.emit(self)
	
	
	
func help(mast):
	master = mast
	mode = MODES.HELP

func go_fight_alien():
	mode = MODES.ATTACK_ALIEN
	pass
