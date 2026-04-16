class_name PlayerController extends Node

var input_dir: Vector2

@export var interaction_probe: InteractionProbe
@export var movement: MovementComponent
@export var camera_pivot: PlayerCamera
@export var combat: PlayerCombatComponent

@export_group("Input Actions")
## Name of Input Action to move Left.
@export var input_left : String = "move_left"
## Name of Input Action to move Right.
@export var input_right : String = "move_right"
## Name of Input Action to move Forward.
@export var input_forward : String = "move_forward"
## Name of Input Action to move Backward.
@export var input_back : String = "move_backward"
## Name of Input Action to Jump.
@export var input_jump : String = "action_jump"
## Name of Input action to Interact
@export var input_interact : String = "action_interact";
## Name of Input action to Attack
@export var input_attack : String = "action_attack";
## Name of Input Action to Sprint.
@export var input_sprint : String = "action_sprint"
## Name of Input Action to toggle freefly mode.
@export var input_freefly : String = "debug_freefly"

func _ready() -> void:
	check_input_mappings()
	
func _process(delta) -> void:
	input_dir = Input.get_vector(input_left, input_right, input_forward, input_back)
	
	'''
	if can_freefly and freeflying:
		var input_dir : Vector2 = player_controller.input_dir
		var motion := (camera_pivot.global_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		movement.motion = motion * freefly_speed * delta
		return
	'''
	
	var input_camera_dir : Vector2 = input_dir.rotated(-camera_pivot.rotation.y) # camera pivot is facing opposite direction of camera
	var move_dir : Vector3 = (Vector3(input_camera_dir.x, 0, input_camera_dir.y)).normalized()
	movement.move(move_dir)
	
	if Input.is_action_just_pressed(input_jump):
		movement.jump()
		
	if Input.is_action_just_pressed(input_attack):
		combat.do_attack()

func _unhandled_input(event: InputEvent) -> void:
	'''
	# Toggle freefly mode
	if Input.is_action_just_pressed(input_freefly):
		movement.toggle_freefly()
	'''
	if Input.is_action_just_pressed(input_interact):
		interaction_probe.interact()
	movement.start_sprinting(Input.is_action_pressed(input_sprint))

## Checks if some Input Actions haven't been created.
## Disables functionality accordingly.
func check_input_mappings() -> void:
	if not InputMap.has_action(input_left):
		push_error("Movement disabled. No InputAction found for input_left: " + input_left)
	if not InputMap.has_action(input_right):
		push_error("Movement disabled. No InputAction found for input_right: " + input_right)
	if not InputMap.has_action(input_forward):
		push_error("Movement disabled. No InputAction found for input_forward: " + input_forward)
	if not InputMap.has_action(input_back):
		push_error("Movement disabled. No InputAction found for input_back: " + input_back)
	if not InputMap.has_action(input_jump):
		push_error("Jumping disabled. No InputAction found for input_jump: " + input_jump)
	if InputMap.has_action(input_sprint):
		push_error("Sprinting disabled. No InputAction found for input_sprint: " + input_sprint)
	if InputMap.has_action(input_freefly):
		push_error("Freefly disabled. No InputAction found for input_freefly: " + input_freefly)
