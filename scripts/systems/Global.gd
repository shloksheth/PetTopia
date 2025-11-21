extends Node

# --- Currency tracking ---
var coins: int = 0
var gems: int = 0

# --- Signals for UI updates ---
signal coins_changed(new_value: int)
signal gems_changed(new_value: int)

# --- Coin functions ---
func add_coins(amount: int) -> void:
	coins += amount
	emit_signal("coins_changed", coins)

func spend_coins(amount: int) -> bool:	
	if coins >= amount:
		coins -= amount
		emit_signal("coins_changed", coins)
		return true
	return false

# --- Gem functions ---
func add_gems(amount: int) -> void:
	gems += amount
	emit_signal("gems_changed", gems)

func spend_gems(amount: int) -> bool:
	if gems >= amount:
		gems -= amount
		emit_signal("gems_changed", gems)
		return true
	return false
