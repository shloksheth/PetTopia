extends PopupPanel

@onready var volume_slider: HSlider = $VBoxContainer/HBoxContainer/VolumeSlider
@onready var close_button: Button = $VBoxContainer/CloseButton

func _ready() -> void:
	close_button.pressed.connect(_on_close_pressed)
	volume_slider.value_changed.connect(_on_volume_changed)

func _on_close_pressed() -> void:
	hide()

func _on_volume_changed(value: float) -> void:
	# Example: adjust master audio bus volume
	var db = linear_to_db(value / 100.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db)
