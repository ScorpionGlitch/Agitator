extends Node

var target: Vector3 = Vector3(0, 1.5, 0)

@onready var game_character: CharacterBody3D = get_parent()
@export var movement: MovementComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void :
	target.x = randf_range(-7.0, 7.0)
	target.z = randf_range(-7.0, 7.0)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_dir: Vector3 = target - game_character.position
	movement.move(move_dir.normalized())

func _on_timer_timeout():
	var x = randf_range(-7.0, 7.0)
	var y = 1.5
	var z = randf_range(-7.0, 7.0)
	target = Vector3(x, y, z)
