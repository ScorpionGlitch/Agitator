extends Node3D

@onready var game_character: CharacterBody3D = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_dir = Vector3(game_character.velocity.x, 0, game_character.velocity.z)
	if (move_dir):
		rotation.y = lerp_angle(rotation.y, Vector3.FORWARD.signed_angle_to(-move_dir,Vector3.UP), delta * 6.0)
