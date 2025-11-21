extends Node

@onready var hunger_bar = $HungerBar
@onready var happiness_bar = $HappinessBar
@onready var energy_bar = $EnergyBar


func _ready():
	# Connect to Global signals
	Global.stats_updated.connect(_update_stats)

	hunger_bar.add_theme_color_override("fg_color", Color.RED)
	happiness_bar.add_theme_color_override("fg_color", Color.GREEN)
	energy_bar.add_theme_color_override("fg_color", Color.YELLOW)

	# Initialize bars
	_update_stats()

func _update_stats():
	var stats = Global.get_stats()
	hunger_bar.value = stats["hunger"]
	happiness_bar.value = stats["happiness"]
	energy_bar.value = stats["energy"]
