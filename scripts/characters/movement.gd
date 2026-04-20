extends Node
class_name MovementComponent

@onready var game_character: CharacterBody3D = get_parent()

## Can we move around?
@export var can_move : bool = true
## Are we affected by gravity?
@export var can_jump : bool = true
## Are we affected by gravity?
@export var has_gravity : bool = true
## Can we hold to run?
@export var can_sprint : bool = false
## Can we press to enter freefly mode (noclip)?
@export var can_freefly : bool = false

@export_group("Speeds")
## Normal speed.
@export var base_speed : float = 2.5
## Speed of jump.
@export var jump_velocity : float = 4.5
## How fast do we run?
@export var sprint_speed : float = 3.0
## How fast do we freefly?
@export var freefly_speed : float = 25.0

var horizontal_speed: float

var motion: Vector3

var move_speed : float = base_speed
var _acc_speed : float = .01
var freeflying : bool = false

func _ready() -> void:
	move_speed = base_speed
	freeflying = false

func _physics_process(delta):
	'''
	# this is for freefly
	game_character.move_and_collide(motion)
	'''
	# Apply gravity to velocity
	if has_gravity:
		if not game_character.is_on_floor():
			game_character.velocity += game_character.get_gravity() * delta
		else:
			horizontal_speed = Vector2(game_character.velocity.x, game_character.velocity.z).length()
	# Use velocity to actually move
	game_character.move_and_slide()

func move(move_dir) -> void:
	# Apply desired movement to velocity
	if can_move:
		if move_dir:
			game_character.velocity.x = move_toward(game_character.velocity.x, move_dir.x * move_speed, _acc_speed)
			game_character.velocity.z = move_toward(game_character.velocity.z, move_dir.z * move_speed, _acc_speed)
		else:
			game_character.velocity.x = move_toward(game_character.velocity.x, 0, _acc_speed)
			game_character.velocity.z = move_toward(game_character.velocity.z, 0, _acc_speed)
	else:
		game_character.velocity.x = 0
		game_character.velocity.z = 0
	pass

func jump() -> void:
	# Apply jumping
	if can_jump and game_character.is_on_floor():
		game_character.velocity.y = jump_velocity

func start_sprinting(sprint:bool) -> void:
	if can_sprint and sprint:
		move_speed = sprint_speed
	else:
		move_speed = base_speed

func toggle_freefly() -> void:
	if (can_freefly and not freeflying):
		game_character.collider.disabled = true
		freeflying = true
		game_character.velocity = Vector3.ZERO
	else:
		game_character.collider.disabled = false
		freeflying = false
		
