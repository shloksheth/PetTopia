extends TextureProgressBar

@onready var hunger_label = $HungerLabel

func _ready() -> void:
	value = Global.hunger
	Global.stats_updated.connect(_update_bar)
	hunger_label.text = str(int(value))

func _update_bar() -> void:
	value = Global.hunger
	hunger_label.text = str(int(value))

func _process(delta: float) -> void:
	pass
