extends Node

@onready var hunger_bar: ProgressBar = $HungerBar
@onready var energy_bar: ProgressBar = $EnergyBar
@onready var stats_timer: Timer = $StatsTimer

func _ready() -> void:
	Global.stats_updated.connect(_update_stats)
	hunger_bar.add_theme_color_override("fg_color", Color.RED)
	energy_bar.add_theme_color_override("fg_color", Color.YELLOW)
	_update_stats()
	stats_timer.timeout.connect(_on_stats_timer_timeout)

func _update_stats() -> void:
	var stats: Dictionary = Global.get_stats()
	print("Updating bars:", stats)
	hunger_bar.value = stats.get("hunger", 0)
	energy_bar.value = stats.get("energy", 0)

	if hunger_bar.value <= 10:
		hunger_bar.add_theme_color_override("fg_color", Color(1, 0, 0))
	elif hunger_bar.value <= 25:
		hunger_bar.add_theme_color_override("fg_color", Color(1, 0.5, 0))
	else:
		hunger_bar.add_theme_color_override("fg_color", Color.RED)

	if energy_bar.value <= 10:
		energy_bar.add_theme_color_override("fg_color", Color(1, 0, 0))
	elif energy_bar.value <= 25:
		energy_bar.add_theme_color_override("fg_color", Color(1, 0.5, 0))
	else:
		energy_bar.add_theme_color_override("fg_color", Color.YELLOW)

func _on_stats_timer_timeout() -> void:
	Global.modify_stats(-2, -2)
