extends Node
class_name PlayerCombatComponent

signal punch

@export var interaction_probe: InteractionProbe
@export var attack_damage: int = 1
@export var attack_cooldown: float = 0.4

var can_attack: bool = true

func _ready() -> void:
	pass

func do_attack():
	if not can_attack:
		return
	can_attack = false
	emit_signal("punch")
	var target = null
	if interaction_probe:
		target = interaction_probe.get_target_in_sight()
		if target:
			var health_comp = target.get_node_or_null("HealthComponent")
			if health_comp:
				health_comp.take_damage(attack_damage)
			else:
				push_warning("PlayerCombatComponent: target %s has no HealthComponent" % target.name)
	# Cooldown
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
