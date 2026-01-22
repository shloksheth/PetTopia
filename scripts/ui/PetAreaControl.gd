extends Control

@onready var pet_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var pet_name_label: RichTextLabel = $PetNameLabel
@onready var rename_button: Button = $RenameButton

func _ready() -> void:
	pet_sprite.play("idle")
	pet_name_label.text = Global.pet_name
	Global.stats_updated.connect(_update_name)
	rename_button.pressed.connect(_on_rename_pressed)

func _update_name() -> void:
	pet_name_label.text = Global.pet_name

func _on_rename_pressed() -> void:
	var popup := AcceptDialog.new()
	popup.title = "Rename Pet"

	var container := VBoxContainer.new()
	var name_edit := LineEdit.new()
	name_edit.text = Global.pet_name

	container.add_child(name_edit)
	popup.add_child(container)
	add_child(popup)

	popup.popup_centered()
	name_edit.grab_focus()
	name_edit.select_all()

	name_edit.text_submitted.connect(func(new_text):
		_set_pet_name(new_text)
		popup.queue_free()
	)

	var ok := popup.get_ok_button()
	ok.pressed.connect(func():
		_set_pet_name(name_edit.text)
		popup.queue_free()
	)

func _set_pet_name(new_name: String) -> void:
	Global.pet_name = new_name
