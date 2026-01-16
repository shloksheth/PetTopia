extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	Global.add_coins(100)   # give yourself 100 coins
