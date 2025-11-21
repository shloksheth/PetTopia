extends Node

# --- Currency & name tracking ---
var coins: int = 0
var gems: int = 0
var player_name: String = ""

signal coins_changed(new_value: int)
signal gems_changed(new_value: int)
signal name_changed(new_value: String)

const SAVE_PATH := "user://save_data.json"

func _ready() -> void:
	load_data()

func add_coins(amount: int) -> void:
	coins += amount
	coins_changed.emit(coins)
	save_data()

func add_gems(amount: int) -> void:
	gems += amount
	gems_changed.emit(gems)
	save_data()

func set_player_name(new_name: String) -> void:
	player_name = new_name
	name_changed.emit(player_name)
	save_data()

func save_data() -> void:
	var data: Dictionary = {
		"coins": coins,
		"gems": gems,
		"name": player_name
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()

func load_data() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
		var content: String = file.get_as_text()
		file.close()

		var result: Dictionary = JSON.parse_string(content)
		if typeof(result) == TYPE_DICTIONARY:
			coins = result.get("coins", 0)
			gems = result.get("gems", 0)
			player_name = result.get("name", "")
