extends Control

@onready var food_button: Button = $FoodButton
@onready var food_popup: PopupPanel = $FoodPopup
@onready var food_list: VBoxContainer = $FoodPopup/FoodList

func _ready() -> void:
	food_button.pressed.connect(_on_food_button_pressed)
	Global.food_changed.connect(_update_food_list)
	_update_food_list(Global.food_inventory)
	_set_button_style()

func _on_food_button_pressed() -> void:
	food_popup.popup_centered(Vector2i(400, 300))

func _update_food_list(food: Dictionary) -> void:
	for child in food_list.get_children():
		food_list.remove_child(child)
		child.queue_free()
	for item in food.keys():
		var count: int = food[item]
		var btn := Button.new()
		btn.text = "%s (%d left)" % [item, count]
		btn.pressed.connect(func(): _on_food_selected(item))
		food_list.add_child(btn)

func _on_food_selected(item: String) -> void:
	Global.consume_food(item)

func _set_button_style() -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.992, 0.643, 0.584, 1.0)
	food_button.add_theme_stylebox_override("normal", style)

	var hover := style.duplicate()
	hover.bg_color = Color(0.3, 0.7, 1.0)
	food_button.add_theme_stylebox_override("hover", hover)

	var pressed := style.duplicate()
	pressed.bg_color = Color(0.1, 0.4, 0.7)
	food_button.add_theme_stylebox_override("pressed", pressed)
