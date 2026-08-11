extends Node
class_name DialogComonent

@export var npc_id: String
@export var npc_name: String

@export var dialog_resource: DialogResource
var current_state = "start"
var current_branch_index = 0

func _ready():
	dialog_resource.load_from_json("res://Resources/Dialog/dialog_data.json")
	
func StartDialog() -> void:
	var npc_dialogs = dialog_resource.get_npc_dialog(npc_id)
	if npc_dialogs.is_empty():
		print("interacting with component: " + npc_name)

func get_current_dialog():
	var npc_dialogs = dialog_resource.get_npc_dialog(npc_id)
	if current_branch_index < npc_dialogs.size():
		for dialog in npc_dialogs[current_branch_index]["dialgos"]:
			if dialog["state"] == current_state:
				return dialog
				
	return null
	
func set_dialog_tree(branch_index):
	current_branch_index = branch_index
	current_state = "start"

func set_dialog_state(state):
	current_state = state
