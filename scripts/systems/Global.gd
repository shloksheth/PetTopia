extends Node

# --- Currency, food, and pet stats tracking ---
var coins: int = 0
var gems: int = 0

var food_inventory: Dictionary = {
	"Apple": 3,
	"Meat": 2,
	"Fish": 1,
	"Pizza": 1
}

var hunger: int = 50    # 0–100
var energy: int = 75    # 0–100

signal coins_changed(new_value: int)
signal gems_changed(new_value: int)
signal food_changed(food: Dictionary)
signal stats_updated()

const SAVE_PATH := "user://save_data.json"

func _ready() -> void:
	load_data()

# --- Currency ---
func add_coins(amount: int) -> void:
	coins += amount
	coins_changed.emit(coins)
	save_data()

func add_gems(amount: int) -> void:
	gems += amount
	gems_changed.emit(gems)
	save_data()

# --- Food ---
func consume_food(item: String) -> void:
	if food_inventory.has(item) and food_inventory[item] > 0:
		food_inventory[item] -= 1
		# Eating restores hunger and energy
		print("After eating:", hunger, energy)
		hunger = clamp(hunger + 10, 0, 100)
		energy = clamp(energy + 5, 0, 100)
		print("Types:", typeof(hunger), typeof(energy))

		food_changed.emit(food_inventory)
		stats_updated.emit()
		save_data()

# --- Stats ---
func get_stats() -> Dictionary:
	return {
		"hunger": hunger,
		"energy": energy
	}

func modify_stats(hunger_delta: int, energy_delta: int) -> void:
	hunger = clamp(hunger + hunger_delta, 0, 100)
	energy = clamp(energy + energy_delta, 0, 100)
	stats_updated.emit()
	save_data()

# --- Save/Load ---
func save_data() -> void:
	var data: Dictionary = {
		"coins": coins,
		"gems": gems,
		"food": food_inventory,
		"hunger": hunger,
		"energy": energy
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
			hunger = result.get("hunger", 50)
			energy = result.get("energy", 75)
