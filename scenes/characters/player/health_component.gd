extends Node
class_name HealthComponent

@export var max_health: int = 10
var current_health: int

signal health_changed(new_health: int)
signal died

func _ready() -> void:
	current_health = max_health

func take_damage(amount: int) -> void:
	current_health = max(current_health - amount, 0)
	emit_signal("health_changed", current_health)
	print("%s took %d damage (%d/%d)" % [get_parent().name, amount, current_health, max_health])
	
	if current_health <= 0:
		die()

func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	emit_signal("health_changed", current_health)

func die() -> void:
	print("%s died." % get_parent().name)
	emit_signal("died")
	get_parent().queue_free()  # Or handle death another way
