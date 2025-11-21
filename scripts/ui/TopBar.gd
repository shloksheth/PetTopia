extends Control

# --- UI references ---
@onready var coinlabel: Label = $coinlabel
@onready var gemlabel: Label = $gemlabel
@onready var settings_menu: MenuButton = $settingoutline/SettingsMenu
@onready var settings_popup: PopupPanel = $"../SettingsPopup"  # adjust path if popup is not sibling

func _ready() -> void:
	# Initialize labels with current values
	coinlabel.text = str(Global.coins)
	gemlabel.text = str(Global.gems)

	# Connect currency signals
	Global.coins_changed.connect(_on_coins_changed)
	Global.gems_changed.connect(_on_gems_changed)

	# Setup Settings menu items
	var popup = settings_menu.get_popup()
	popup.add_item("Settings", 0)
	popup.add_item("Help", 1)
	popup.add_item("Exit", 2)
	popup.id_pressed.connect(_on_menu_item_pressed)
	print("Popup items:", settings_menu.get_popup().get_item_count())

# --- Currency updates ---
func _on_coins_changed(new_value: int) -> void:
	coinlabel.text = str(new_value)

func _on_gems_changed(new_value: int) -> void:
	gemlabel.text = str(new_value)

# --- Settings menu actions ---
func _on_menu_item_pressed(id: int) -> void:
	match id:
		0:
			settings_popup.popup_centered()   # open SettingsPopup
		1:
			print("Help selected")            # replace with HelpPopup later
		2:
			get_tree().quit()                 # exit game
