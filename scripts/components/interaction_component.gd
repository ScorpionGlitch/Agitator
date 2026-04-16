extends Node
class_name InterationComponent

signal Interacted

func interact() -> void:
	Interacted.emit()
