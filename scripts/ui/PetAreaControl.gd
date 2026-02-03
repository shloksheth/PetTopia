extends Control

@onready var pet_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var pet_name_label: RichTextLabel = $PetNameLabel
@onready var rename_button: Button = $RenameButton

var pet_name: String = "Fluffy"

func _ready() -> void:
	pet_sprite.play("idle")
	pet_name_label.text = pet_name
	rename_button.pressed.connect(_on_rename_pressed)

func _on_rename_pressed() -> void:
	var popup := AcceptDialog.new()
	popup.title = "Rename Pet"
	popup.dialog_hide_on_ok = true  # default, but explicit

	var name_edit := LineEdit.new()
	name_edit.custom_minimum_size = Vector2(240, 0)
	name_edit.focus_mode = Control.FOCUS_ALL

# Add the LineEdit to the dialog's content
	popup.add_child(name_edit)
	add_child(popup)

# Show centered and focus the input
	popup.popup_centered()
	name_edit.grab_focus()
	name_edit.select_all()

# Enter key (text_submitted) updates name
	name_edit.text_submitted.connect(func(new_text: String) -> void:
		set_pet_name(new_text)
		popup.queue_free()
)

# OK button explicitly updates name
	var ok := popup.get_ok_button()
	if ok:
		ok.pressed.connect(func() -> void:
			set_pet_name(name_edit.text)
			popup.queue_free()
		)

# Also handle the dialog-level confirmed signal (belt and suspenders)
	popup.confirmed.connect(func() -> void:
		set_pet_name(name_edit.text)
		popup.queue_free()
)

func set_pet_name(new_name: String) -> void:
	pet_name = new_name
	pet_name_label.text = new_name
