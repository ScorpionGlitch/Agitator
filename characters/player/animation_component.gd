extends AnimationTree

@export var movement_component: MovementComponent

func _ready():
	pass

func _process(delta):
	set("parameters/Locomotion/blend_position", movement_component.horizontal_speed)
	pass


func _on_player_combat_component_punch() -> void:
	set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	pass # Replace with function body.
