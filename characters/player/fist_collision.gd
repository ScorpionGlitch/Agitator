extends Area3D
class_name FistCollision

signal fist_hit(target: Node)

func _ready() -> void:
	$FistCollisionShape3D.disabled = true
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	print($FistCollisionShape3D.disabled)
	emit_signal("fist_hit", body)
