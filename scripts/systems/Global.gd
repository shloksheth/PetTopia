extends Node

# --- Currency and food tracking ---
var coins: int = 0
var gems: int = 0
var food_inventory: Dictionary = {
	"Apple": 3,
	"Meat": 2,
	"Fish": 1
}

signal coins_changed(new_value: int)
signal gems_changed(new_value: int)
signal food_changed(food: Dictionary)

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

func consume_food(item: String) -> void:
	if food_inventory.has(item) and food_inventory[item] > 0:
		food_inventory[item] -= 1
		food_changed.emit(food_inventory)
		save_data()

func save_data() -> void:
	var data: Dictionary = {
		"coins": coins,
		"gems": gems,
		"food": food_inventory
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
			food_inventory = result.get("food", food_inventory)
