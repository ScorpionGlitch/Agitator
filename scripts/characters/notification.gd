extends MeshInstance3D

func _on_interaction_probe_collided(collider):
	if collider and collider.get_node_or_null("Interaction"):
		visible = true
	else:
		visible = false
	pass # Replace with function body.
