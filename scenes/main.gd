extends Control

func _ready() -> void:
	change_screen("res://scenes/home/Home.tscn")

func change_screen(path: String) -> void:
	var container := $ScreenContainer

	# Remove old screen
	for child in container.get_children():
		child.queue_free()

	# Load new screen
	var scene: Node = load(path).instantiate()
	container.add_child(scene)
