extends Node
class_name HitFlashComponent

@export var flash_duration := 0.1
var original_color: Color
var mesh_instance#: MeshInstance3D

func _ready() -> void:
	mesh_instance = get_parent().get_node("Armature/GeneralSkeleton/Alpha_Surface")
	mesh_instance.set_surface_override_material(0, mesh_instance.get_active_material(0).duplicate())
	if mesh_instance.get_surface_override_material_count() > 0:
		original_color = mesh_instance.get_active_material(0).albedo_color
	else:
		original_color = Color.WHITE

	var health = get_parent().get_node_or_null("HealthComponent")
	if health:
		health.connect("health_changed", _on_health_changed)

func _on_health_changed(new_health: int) -> void:
	_flash()

func _flash() -> void:
	mesh_instance.get_active_material(0).albedo_color = Color.RED
	await get_tree().create_timer(flash_duration).timeout
	mesh_instance.get_active_material(0).albedo_color = original_color
	pass
