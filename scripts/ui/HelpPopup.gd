extends PopupPanel

@onready var close_button: Button = $MarginContainer/VBoxContainer/CloseButton
@onready var body_label: Label = $MarginContainer/VBoxContainer/Label

func _ready() -> void:
	# Connect close button
	close_button.pressed.connect(_on_close_pressed)

	# Ensure help text wraps instead of stretching the popup
	body_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	body_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT

func _on_close_pressed() -> void:
	hide()

# Optional helper to set text dynamically
func set_help_text(text: String) -> void:
	body_label.text = text
