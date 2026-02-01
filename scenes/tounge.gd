extends CharacterBody3D


const SPEED = 40.0
const JUMP_VELOCITY = 4.5
signal death


enum MODES{WALKING, ATTACKING}

var mode : MODES = MODES.WALKING

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
				current_target =(get_tree().get_first_node_in_group("path") as Path3D).position + (get_tree().get_first_node_in_group("path") as Path3D).curve.get_point_position(index)

func _exit_tree():
	death.emit(self)
