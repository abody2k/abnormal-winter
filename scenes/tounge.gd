extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
signal death

func _physics_process(delta):
	pass


func _exit_tree():
	death.emit(self)
