extends TextureProgressBar

@onready var energy_label = $EnergyLabel

func _ready() -> void:
	value = Global.energy
	Global.stats_updated.connect(_update_bar)
	energy_label.text = str(int(value))

func _update_bar() -> void:
	value = Global.energy
	energy_label.text = str(int(value))

func _process(delta: float) -> void:
	pass
