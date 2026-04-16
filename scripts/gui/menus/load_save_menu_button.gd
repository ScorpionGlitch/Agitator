@tool
extends Control 
class_name LoadSaveMenuButton 

@export var initial_text: String = "Default Label": 
	set(value): 
		initial_text = value
		print("Setter called, button is ", button)
		if button: 
			button.text = initial_text; 

@onready var button = $Button 

func _ready() -> void: 
	setLabelText(initial_text) 
	pass 

func setLabelText(text : String): 
	button.text = text 
	pass
