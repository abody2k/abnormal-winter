extends Area3D



func _on_body_entered(body):
	
	if body.call("collect_bag"):
		queue_free()
