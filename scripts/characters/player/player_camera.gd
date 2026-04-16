extends Node3D
class_name PlayerCamera

## IMPORTANT REFERENCES
@export var camera_target: Node3D
@export var camera: Camera3D

@export_group("Speeds")
## Look around rotation speed.
@export var look_speed : float = 0.002
## Normal speed.
var camera_speed = 6.0

var mouse_captured : bool = false
var look_rotation : Vector2

func _ready() -> void:
	look_rotation.y = rotation.y
	look_rotation.x = rotation.x

func _process(delta) -> void:
	camera.position = lerp(camera.position, camera_target.position, delta*camera_speed)

func _unhandled_input(event: InputEvent) -> void:
	# Mouse capturing
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		capture_mouse()
	if Input.is_key_pressed(KEY_ESCAPE):
		release_mouse()
	# Look around
	if mouse_captured and event is InputEventMouseMotion:
		rotate_look(event.relative)

## Rotate us to look around.
## Base of controller rotates around y (left/right). Head rotates around x (up/down).
## Modifies look_rotation based on rot_input, then resets basis and rotates by look_rotation.
func rotate_look(rot_input : Vector2) -> void:
	look_rotation.x -= rot_input.y * look_speed
	look_rotation.x = clamp(look_rotation.x, deg_to_rad(-90), deg_to_rad(0))
	look_rotation.y -= rot_input.x * look_speed
	look_rotation.y = wrapf(look_rotation.y, 0.0, TAU)
	rotation.y = look_rotation.y
	rotation.x = look_rotation.x
	
func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true


func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false
