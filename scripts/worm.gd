extends CharacterBody3D


const SPEED = 30.0
const JUMP_VELOCITY = 4.5
signal death


enum MODES{IDLE,WALKING, CHASING, ATTACKING}

var mode : MODES = MODES.WALKING

var current_target = Vector3.ZERO
var index = 0


var enemies = []
var target : CharacterBody3D = null 


func _ready():
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

				$AnimationPlayer.play("worm_moving")
				$AnimationPlayer.speed_scale = 2
			else:
				$AnimationPlayer.play("worm_idle")
				$AnimationPlayer.speed_scale = 1
				index +=1
				if index >= (get_tree().get_first_node_in_group("path") as Path3D).curve.point_count:
					mode = MODES.IDLE
					return
				current_target =(get_tree().get_first_node_in_group("path") as Path3D).position + (get_tree().get_first_node_in_group("path") as Path3D).curve.get_point_position(index)
		MODES.CHASING:
			$AnimationPlayer.play("worm_moving")

			if position.distance_to(target.position) < 17:
				mode = MODES.ATTACKING
			else:
				look_at(Vector3(target.position.x,position.y,target.position.z))
				velocity =( -basis.z + Vector3.DOWN ) * SPEED
				var dir = (Vector3(target.position.x,position.y,target.position.z) - position).normalized()
				dir.y=0
				rotation.y = atan2(dir.x,dir.z)
				move_and_slide()
		MODES.ATTACKING:
			if position.distance_to(target.position) >= 17:
				mode = MODES.CHASING
			else:
				var dir = (target.position - position).normalized()
				dir.y=0
				rotation.y = atan2(dir.x,dir.z)
				#$attack.start()
				var x = create_tween()
				
				x.tween_callback(func () : $BoneAttachment3D/enemy.monitoring = true).set_delay(0.2)
				#x.tween_property($BoneAttachment3D/enemy,"monitoring",true,0.2)
				$AnimationPlayer.speed_scale =2
				#$BoneAttachment3D/enemy.monitoring = true
				$AnimationPlayer.play("worm_attack")
				
func _exit_tree():
	get_tree().call_group("main","worm_died")
	death.emit(self)


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
	return
	remove_enemy(body)
	
	


func _on_area_3d_body_entered(body):
	remove_enemy(body)
	body.queue_free()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "worm_attack":
		#pass
		$BoneAttachment3D/enemy.monitoring = false
		


func _on_attack_timeout():
	$BoneAttachment3D/enemy.monitoring = true
