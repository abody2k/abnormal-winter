extends Node3D



signal finished_growing

func _ready():
	$AnimationPlayer.play("plant_growing")
	
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "plant_growing":
		$AnimationPlayer.play("tree_blowing")
	else:
		finished_growing.emit()
		queue_free()
	
