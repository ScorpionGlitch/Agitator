extends Node
class_name PlayerCombatComponent

signal punch
signal hit_frame_reached

@export var attack_damage: int = 1
@export var attack_cooldown: float = 0.4

@export var fist_collision: FistCollision

var can_attack: bool = true

func _ready() -> void:
	fist_collision.fist_hit.connect(_on_fist_hit)
	pass

func _on_fist_hit(target: Node) -> void:
	var health_comp = target.get_node_or_null("HealthComponent")
	if health_comp:
		health_comp.take_damage(attack_damage)
	else:
		push_warning("PlayerCombatComponent: target %s has no HealthComponent" % target.name)
	pass

func _on_hit_frame() -> void:
	emit_signal("hit_frame_reached")

func do_attack():
	if not can_attack:
		return
	can_attack = false
	emit_signal("punch")
	# Cooldown
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
