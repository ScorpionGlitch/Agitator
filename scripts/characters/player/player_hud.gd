extends CanvasLayer

@onready var amount = $Coins/Amount
@onready var quest_tracker = $QuestTracker
@onready var title = $QuestTracker/Details/Title
@onready var objectives = $QuestTracker/Details/Objectives

func _ready() -> void:
	quest_tracker.visible = false
