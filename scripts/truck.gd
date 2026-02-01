extends Area3D




var enemies = []
var target : CharacterBody3D = null
const BULLET = preload("res://scenes/bullet.tscn")

var loaded = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if target:
		$Cube_008/lady.look_at(target.position)
		#$Cube_008/lady.rotation_degrees.y - 270
		if loaded:
			$reloader.start()
			loaded = false
			var bullet = BULLET.instantiate()
			get_parent().add_child(bullet)
			bullet.position =$Cube_008/lady/Cylinder_003/aim.global_position
			bullet.rotation = $Cube_008/lady/Cylinder_003/aim/RayCast3D.global_rotation
			#bullet.look_at(target.position)
			bullet.rotate_y(90)



func _on_body_entered(body):
	if !target:
		target = body
	enemies.append(body)
	pass # Replace with function body.


func _on_body_exited(body):
	remove_enemy(body)



func remove_enemy(enemy):
	enemies = enemies.filter(func (e): return enemy != e)
	if enemy == target:
		target = null
		if enemies.is_empty():
			return
		else :
			target = enemies[0]

func _on_reloader_timeout():
	loaded = true
