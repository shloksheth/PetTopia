extends Node

@onready var hunger_bar: ProgressBar = $HungerBar
@onready var energy_bar: ProgressBar = $EnergyBar
@onready var stats_timer: Timer = $StatsTimer

func _ready() -> void:
	Global.stats_updated.connect(_update_stats)

	# Default colors
	hunger_bar.add_theme_color_override("fg_color", Color.RED)
	energy_bar.add_theme_color_override("fg_color", Color.YELLOW)

	_update_stats()

	stats_timer.timeout.connect(_on_stats_timer_timeout)

func _update_stats() -> void:
	var stats: Dictionary = Global.get_stats()
	hunger_bar.value = stats.get("hunger", 0)
	energy_bar.value = stats.get("energy", 0)

	# --- Visual warnings ---
	# Hunger bar: orange below 25, red below 10
	if hunger_bar.value <= 10:
		hunger_bar.add_theme_color_override("fg_color", Color(1, 0, 0)) # pure red
	elif hunger_bar.value <= 25:
		hunger_bar.add_theme_color_override("fg_color", Color(1, 0.5, 0)) # orange
	else:
		hunger_bar.add_theme_color_override("fg_color", Color(1, 0, 0)) # default red

	# Energy bar: orange below 25, red below 10
	if energy_bar.value <= 10:
		energy_bar.add_theme_color_override("fg_color", Color(1, 0, 0)) # pure red
	elif energy_bar.value <= 25:
		energy_bar.add_theme_color_override("fg_color", Color(1, 0.5, 0)) # orange
	else:
		energy_bar.add_theme_color_override("fg_color", Color(1, 1, 0)) # default yellow

func _on_stats_timer_timeout() -> void:
	# Decrease hunger and energy by 2 every 30 seconds
	Global.modify_stats(-2, -2)
