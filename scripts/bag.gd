extends Area3D



func _on_body_entered(body):
	body.call("collect_bag")
	queue_free()
