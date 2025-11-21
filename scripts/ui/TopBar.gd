extends Control

@onready var coinlabel: Label = $coinlabel
@onready var gemlabel: Label = $gemlabel
@onready var settings_menu: MenuButton = $settingoutline/SettingsMenu
@onready var settings_popup: PopupPanel = $"../SettingsPopup"
@onready var help_popup: PopupPanel = $"../Help Popup"

func _ready() -> void:
	coinlabel.text = str(Global.coins)
	gemlabel.text = str(Global.gems)

	Global.coins_changed.connect(_on_coins_changed)
	Global.gems_changed.connect(_on_gems_changed)

	var popup := settings_menu.get_popup()
	popup.clear()
	popup.add_item("Settings", 0)
	popup.add_item("Help", 1)
	popup.add_item("Exit", 2)
	popup.id_pressed.connect(_on_menu_item_pressed)

func _on_coins_changed(new_value: int) -> void:
	coinlabel.text = str(new_value)

func _on_gems_changed(new_value: int) -> void:
	gemlabel.text = str(new_value)

func _on_menu_item_pressed(id: int) -> void:
	match id:
		0:
			settings_popup.popup_centered(Vector2i(600, 320))
		1:
			help_popup.popup_centered(Vector2i(600, 320))
		2:
			get_tree().quit()
