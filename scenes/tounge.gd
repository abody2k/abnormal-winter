extends CharacterBody3D


const SPEED = 20.0
const JUMP_VELOCITY = 4.5
signal death


enum MODES{WALKING, ATTACKING}

var mode : MODES = MODES.WALKING

var current_target = Vector3.ZERO
var index = 0

func _ready():
	current_target = (get_tree().get_first_node_in_group("path") as Path3D).curve.get_point_in(index)
	current_target.y = position.y

func _physics_process(delta):
	
	match mode:
		MODES.WALKING:
			if position.distance_to(Vector3(current_target.x,position.y,current_target.z) ) > 10.0:
				look_at(Vector3(current_target.x,position.y,current_target.z))
				velocity =( basis.z + Vector3.DOWN * 10) * SPEED 
				move_and_slide()
			else:
				index +=1
				current_target = (get_tree().get_first_node_in_group("path") as Path3D).curve.get_point_in(index)
				current_target.y = position.y

func _exit_tree():
	death.emit(self)
