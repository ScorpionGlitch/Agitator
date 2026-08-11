extends Node3D

var intro_scorpion_glitch: Node

@onready var demo_scene: PackedScene = preload("res://gui/menus/MainMenu.tscn")
#@onready var demo_scene: PackedScene = preload("res://gui/menus/LoadSaveMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	intro_scorpion_glitch = get_node('IntroScorpionGlitch')

var count = 0

func _on_timer_timeout():
	count += 1
	if count <= 3:
		print(str(count))
		if count == 3:
			remove_child(intro_scorpion_glitch)
			var demo_temp = demo_scene.instantiate()
			add_child(demo_temp)

#			var result = SaveManager.newGame(0)
#			var result = SaveManager.loadSlot(2)
#			SaveManager.deleteSlot(1)
#			result = SaveManager.addSaveData("PlayerName", "Archer")
