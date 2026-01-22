extends Node

var coins: int = 0
var gems: int = 0

var food_inventory: Dictionary = {
	"Apple": 3,
	"Meat": 2,
	"Fish": 1,
	"Pizza": 1
}

var hunger: int = 100
var energy: int = 100
var pet_name: String = "Fluffy"

signal coins_changed(new_value: int)
signal gems_changed(new_value: int)
signal food_changed(food: Dictionary)
signal stats_updated()

const SAVE_PATH := "user://save_data.json"

func _ready() -> void:
	randomize()
	load_data()

	var hunger_timer_small := Timer.new()
	hunger_timer_small.wait_time = 4.0
	hunger_timer_small.autostart = true
	add_child(hunger_timer_small)
	hunger_timer_small.timeout.connect(_on_hunger_timer_small_timeout)

	var hunger_timer_big := Timer.new()
	hunger_timer_big.wait_time = 9.0
	hunger_timer_big.autostart = true
	add_child(hunger_timer_big)
	hunger_timer_big.timeout.connect(_on_hunger_timer_big_timeout)

	var energy_timer := Timer.new()
	energy_timer.wait_time = 10.0
	energy_timer.autostart = true
	add_child(energy_timer)
	energy_timer.timeout.connect(_on_energy_timer_timeout)

func add_coins(amount: int) -> void:
	coins += amount
	coins_changed.emit(coins)
	stats_updated.emit()
	save_data()

func add_gems(amount: int) -> void:
	gems += amount
	gems_changed.emit(gems)
	stats_updated.emit()
	save_data()

func buy_item(item_name: String, cost: int) -> bool:
	if coins >= cost:
		coins -= cost
		coins_changed.emit(coins)
		food_inventory[item_name] = food_inventory.get(item_name, 0) + 1
		food_changed.emit(food_inventory)
		stats_updated.emit()
		save_data()
		return true
	return false

func consume_food(item: String) -> void:
	if food_inventory.has(item) and food_inventory[item] > 0:
		food_inventory[item] -= 1
		hunger = clamp(hunger + 10, 0, 100)
		energy = clamp(energy + 5, 0, 100)
		food_changed.emit(food_inventory)
		stats_updated.emit()
		save_data()

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

func _on_hunger_timer_small_timeout() -> void:
	var delta := randi_range(0, 2)
	if delta > 0 and hunger > 0:
		hunger = clamp(hunger - delta, 0, 100)
		stats_updated.emit()
		save_data()

func _on_hunger_timer_big_timeout() -> void:
	var delta := randi_range(2, 6)
	if hunger > 0:
		hunger = clamp(hunger - delta, 0, 100)
		stats_updated.emit()
		save_data()

func _on_energy_timer_timeout() -> void:
	var delta := randi_range(2, 4)
	if energy > 0:
		energy = clamp(energy - delta, 0, 100)
		stats_updated.emit()
		save_data()

func save_data() -> void:
	var data: Dictionary = {
		"coins": coins,
		"gems": gems,
		"food": food_inventory,
		"hunger": hunger,
		"energy": energy,
		"pet_name": pet_name
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
			coins = int(result.get("coins", 0))
			gems = int(result.get("gems", 0))
			food_inventory = result.get("food", food_inventory)
			hunger = int(result.get("hunger", 50))
			energy = int(result.get("energy", 75))
			pet_name = result.get("pet_name", "Fluffy")

	stats_updated.emit()
