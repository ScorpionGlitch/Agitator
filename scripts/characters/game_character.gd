extends CharacterBody3D
class_name GameCharacter

@export var npc_name : String = "default"
@export var npc_id : String = "default"

@onready var dialog_component = $DialogComponent

func _ready() -> void:
	dialog_component.npc_name = npc_name
	dialog_component.npc_id = npc_id
	
	print("GameCharacter.ready()")
	pass
