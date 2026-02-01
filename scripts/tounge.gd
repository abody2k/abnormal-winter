extends CharacterBody3D


const SPEED = 40.0
const JUMP_VELOCITY = 4.5
signal death


enum MODES{IDLE,WALKING,CHASING, ATTACKING}

var mode : MODES = MODES.WALKING

var enemies = []

var target : CharacterBody3D = null
var current_target = Vector3.ZERO
var index = 0

func _ready():
	print((get_tree().get_first_node_in_group("path") as Path3D).curve.get_point_position(index))
	current_target =(get_tree().get_first_node_in_group("path") as Path3D).position + (get_tree().get_first_node_in_group("path") as Path3D).curve.get_point_position(index)


func _physics_process(delta):
	
	match mode:
		MODES.WALKING:
			if position.distance_to(Vector3(current_target.x,position.y,current_target.z) ) > 10.0:
				
				#look_at(Vector3(current_target.x,position.y,current_target.z))
				var dir = (Vector3(current_target.x,position.y,current_target.z) - position).normalized()
				dir.y=0
				rotation.y = atan2(dir.x,dir.z)
				velocity =( basis.z + Vector3.DOWN ) * SPEED 
				move_and_slide()
				if is_on_wall():
					velocity = velocity.slide(get_wall_normal())
				$AnimationPlayer.play("tounge_move")
			else:
				$AnimationPlayer.play("tounge_idle")
				index +=1
				if index >= (get_tree().get_first_node_in_group("path") as Path3D).curve.point_count:
					mode = MODES.IDLE
					return
				current_target =(get_tree().get_first_node_in_group("path") as Path3D).position + (get_tree().get_first_node_in_group("path") as Path3D).curve.get_point_position(index)
		MODES.CHASING:
			
			if position.distance_to(target.position) < 15:
				mode = MODES.ATTACKING
			else:
				look_at(Vector3(target.position.x,position.y,target.position.z))
				velocity =( -basis.z + Vector3.DOWN ) * SPEED
				var dir = (Vector3(target.position.x,position.y,target.position.z) - position).normalized()
				dir.y=0
				rotation.y = atan2(dir.x,dir.z)
				move_and_slide()
				$AnimationPlayer.play("tounge_move")
		MODES.ATTACKING:
			if position.distance_to(target.position) >= 15:
				mode = MODES.CHASING
			else:
				var dir = (Vector3(target.position.x,position.y,target.position.z) - position).normalized()
				dir.y=0
				rotation.y = atan2(dir.x,dir.z)
				$BoneAttachment3D/enemy.monitoring = true
				$AnimationPlayer.play("tounge_attack")
				
func _exit_tree():
	death.emit(self)



func remove_enemy(enemy):
	enemies = enemies.filter(func (e): return enemy != e)
	if enemy == target:
		target = null
		mode = MODES.IDLE
		if enemies.is_empty():
			return
		else :
			target = enemies[0]
			
			
			
func _on_detector_body_entered(body):
	if target:
		mode = MODES.CHASING
		
	if enemies.has(target):
		return
	body.death.connect(remove_enemy)
	enemies.append(body)
	
	
	if !target:
		target = body
		mode = MODES.CHASING


func _on_detector_body_exited(body):
	return
	remove_enemy(body)


func _on_enemy_body_entered(body):
	remove_enemy(body)
	body.queue_free()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "tounge_attack":
		$BoneAttachment3D/enemy.monitoring = false
		
