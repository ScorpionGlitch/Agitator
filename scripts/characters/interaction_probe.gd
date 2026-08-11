extends RayCast3D
class_name InteractionProbe

signal collided(collider)

var last_collider: Object

#@onready var game_character: CharacterBody3D = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta) -> void:
#	var move_dir = Vector3(game_character.velocity.x, 0, game_character.velocity.z)
#	if (move_dir):
#		rotation.y = lerp_angle(rotation.y, Vector3.FORWARD.signed_angle_to(-move_dir,Vector3.UP), delta * 6.0)

func interact() -> void:
	if last_collider:
		var interaction_component = last_collider.get_node("InteractionComponent")
		if interaction_component:
			interaction_component.interact()
	pass

func get_target_in_sight():
	return last_collider

func _physics_process(delta) -> void:
	if not is_colliding():
		last_collider = null
		emit_signal("collided", null)
		return
	var found_collider: Object = get_collider()
	if found_collider != last_collider:
		last_collider = found_collider
		emit_signal("collided", found_collider)
