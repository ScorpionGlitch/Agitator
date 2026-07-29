extends AnimationTree

@export var movement_component: MovementComponent
var _blend_tween: Tween

func _process(_delta):
	var horizontal_speed = movement_component.horizontal_speed
	set("parameters/Locomotion/blend_position", horizontal_speed)
	_tween_blend(0.0 if horizontal_speed < 0.01 else 1.0)

func _tween_blend(target: float):
	if _blend_tween and _blend_tween.is_valid():
		if get("parameters/Moving/blend_amount") == target:
			return
		_blend_tween.kill()
	_blend_tween = create_tween()
	_blend_tween.tween_method(
		func(val): set("parameters/Moving/blend_amount", val),
		get("parameters/Moving/blend_amount"),
		target,
		0.2
	)

func _on_player_combat_component_punch() -> void:
	if movement_component.horizontal_speed < 0.01:
		if not get("parameters/PunchStanding/active"):
			set("parameters/PunchStanding/request",
				AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	else:
		if not get("parameters/PunchWalking/active"):
			set("parameters/PunchWalking/request",
				AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
