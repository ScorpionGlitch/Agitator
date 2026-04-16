extends Node

var _max_slots : int = 3
var _save_path: String = ""
var _save_data = {}
var _autosave = {}

func save(slot: int) -> Error:
	var save_data = {
		"player_state": PlayerState.to_dict(),
		"game_state": GameState.to_dict(),
		# add other singletons
	}
	#return _write_save_file(slot, save_data)
	return OK

func load(slot: int) -> Error:
	var data # = _read_save_file(slot)
	if data == null:
		return ERR_DOES_NOT_EXIST
	PlayerState.from_dict(data.get("player_state",{}))
	GameState.from_dict(data.get("game_state", {}))
	# load other singletons similarly
	return OK

func doesSlotExists(slot : int) -> bool:
	return slot >= 0 and slot < _max_slots

#func addSaveData(key: String, value) -> Error:
	#if _save_path == "":
		#return ERR_INVALID_PARAMETER
	#_save_data[key] = value
	#return saveCurrentSlot()
	#
#func getSaveData(key: String):
	#if _save_path == "":
		#return ERR_PARAMETER_RANGE_ERROR
	#if _save_data.has(key):
		#return _save_data[key]
	#return ERR_DOES_NOT_EXIST

func doesSaveExist(slot : int) -> bool:
	if !doesSlotExists(slot):
		return false
	var save_path = "user://save_"+str(slot)+".sav"
	return FileAccess.file_exists(save_path)

func newGame(slot : int) -> Error:
	if doesSaveExist(slot):
		return ERR_ALREADY_EXISTS
	_save_path = "user://save_"+str(slot)+".sav"
	return saveCurrentSlot()

func copySlot(from_slot: int, to_slot: int) -> Error:
	if !doesSlotExists(from_slot):
		return ERR_PARAMETER_RANGE_ERROR
	if !doesSlotExists(to_slot):
		return ERR_PARAMETER_RANGE_ERROR
	if from_slot == to_slot:
		return ERR_FILE_ALREADY_IN_USE
	if !doesSaveExist(from_slot):
		return ERR_DOES_NOT_EXIST
	if doesSaveExist(to_slot):
		return ERR_ALREADY_EXISTS
	loadSlot(from_slot)
	_save_path = "user://save_"+str(to_slot)+".sav"
	var result : int = saveCurrentSlot()
	clearSavePath()
	return result

func clearSavePath():
	_save_path = ""

func deleteSlot(slot: int) -> Error:
	if !doesSlotExists(slot):
		return ERR_PARAMETER_RANGE_ERROR
	if !doesSaveExist(slot):
		return ERR_FILE_NOT_FOUND
	var dir = DirAccess.open("user://")
	if dir == null:
		return ERR_CANT_OPEN
	dir.remove("save_"+str(slot)+".sav")
	return OK

func loadSlot(slot : int) -> Error:
	if !doesSaveExist(slot):
		return ERR_FILE_NOT_FOUND
	var save_path = "user://save_"+str(slot)+".sav"
	_save_path = save_path
	var file = FileAccess.open(_save_path, FileAccess.READ)
	if file == null:
		return ERR_CANT_OPEN
	_autosave = _save_data
	_save_data = file.get_var()
	print("load-end: " + str(_save_data))
	return OK

func saveCurrentSlot() -> Error:
	print("save: " + str(_save_data))
	if _save_path == "":
		return ERR_PARAMETER_RANGE_ERROR
	_save_data["datetime"] = Time.get_datetime_string_from_system(true, true)
	var file = FileAccess.open(_save_path, FileAccess.WRITE)
	if file == null:
		return ERR_CANT_OPEN
	file.store_var(_save_data)
	return OK

func getPlayerName(slot : int):
	var save_path = "user://save_"+str(slot)+".sav"
	if !doesSaveExist(slot):
		return null
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file == null:
		return ERR_CANT_OPEN
	var save_data = file.get_var()
	return save_data["PlayerName"]
	#return null

func getPlayerTime(slot : int):
	var save_path = "user://save_"+str(slot)+".sav"
	if !doesSaveExist(slot):
		return null
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file == null:
		return ERR_CANT_OPEN
	var save_data = file.get_var()
	return save_data["datetime"]
