extends Control

@onready var shop_button: Button = $QuickShopButton
@onready var shop_popup: PopupPanel = $QuickShopPopup
@onready var shop_list: VBoxContainer = $QuickShopPopup/ShopList

func _ready() -> void:
	shop_button.pressed.connect(_on_shop_button_pressed)
	_build_shop_list()

func _on_shop_button_pressed() -> void:
	shop_popup.popup_centered(Vector2i(400, 300))

func _build_shop_list() -> void:
	if not shop_list:
		push_error("ShopList node not found under QuickShopPopup")
		return

	for child in shop_list.get_children():
		shop_list.remove_child(child)
		child.queue_free()

	_add_shop_item("Buy 10 Coins", func(): Global.add_coins(10))
	_add_shop_item("Buy 5 Gems", func(): Global.add_gems(5))
	_add_shop_item("Buy Apple", func(): _add_food("Apple"))
	_add_shop_item("Buy Pizza", func(): _add_food("Pizza"))

func _add_shop_item(label: String, action: Callable) -> void:
	var btn := Button.new()
	btn.text = label
	btn.pressed.connect(action)
	shop_list.add_child(btn)

func _add_food(item: String) -> void:
	if not Global.food_inventory.has(item):
		Global.food_inventory[item] = 0
	Global.food_inventory[item] += 1
	Global.food_changed.emit(Global.food_inventory)
	Global.save_data()
