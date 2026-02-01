extends Area3D




var targets = []
var current_target : CharacterBody3D = null



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if !current_target:
		body = current_target
	targets.append(body)
	pass # Replace with function body.


func _on_body_exited(body):
	pass # Replace with function body.
