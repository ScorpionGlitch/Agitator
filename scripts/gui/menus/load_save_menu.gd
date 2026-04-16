extends CanvasLayer

@onready var load_save_menu_item = $Panel/VBoxContainer/LoadSaveMenuItem
@onready var load_save_menu_item_2 = $Panel/VBoxContainer/LoadSaveMenuItem2
@onready var load_save_menu_item_3 = $Panel/VBoxContainer/LoadSaveMenuItem3


func _ready():
	var PlayerName0 = SaveManager.getPlayerName(0)
	var PlayerTime0 = SaveManager.getPlayerTime(0)
	if (PlayerName0):
		load_save_menu_item.setLabelText(PlayerName0 + " - " + PlayerTime0)
	else:
		load_save_menu_item.setLabelText("save slot empty")
		#load_save_menu_item.visible = false
	var PlayerName1 = SaveManager.getPlayerName(1)
	var PlayerTime1 = SaveManager.getPlayerTime(1)
	if (PlayerName1):
		load_save_menu_item_2.setLabelText(PlayerName1 + " - " + PlayerTime1)
	else:
		load_save_menu_item_2.setLabelText("save slot empty")
		#load_save_menu_item_2.visible = false
	var PlayerName2 = SaveManager.getPlayerName(2)
	var PlayerTime2 = SaveManager.getPlayerTime(2)
	if (PlayerName2):
		load_save_menu_item_3.setLabelText(PlayerName2 + " - " + PlayerTime2)
	else:
		load_save_menu_item_3.setLabelText("save slot empty")
		#load_save_menu_item_3.visible = false
	pass
