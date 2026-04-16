extends Node
class_name PlayerCombatComponent

signal punch

@export var attack_damage: int = 1
@export var attack_cooldown: float = 0.4
var can_attack: bool = true
var player: Node = null

func _ready() -> void:
	player = get_parent()

func do_attack():
	if not can_attack:
		return
	
	can_attack = false
	print("Player attack!")
	emit_signal("punch")
	
	#var anim_component = player.get_node_or_null("Armature/PlayerAnimationComponent")
	#if anim_component:
	#	#anim_component.play_anim("ybot_animations/ybot_right_hook")
	#	anim_component.play_anim("ybot_animations/ybot_right_hook")
	
	var probe = player.get_node_or_null("InteractionProbeComponent")
	var target = null
	if probe:
		target = probe.get_target_in_sight()
		if target:
			var health_comp = target.get_node_or_null("HealthComponent")
			if health_comp:
				health_comp.take_damage(attack_damage)
			else:
				print("Target found but has no HealthComponent:", target.name)
	else:
		print("No probe component found")
	
	# Cooldown
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
