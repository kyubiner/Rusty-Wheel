extends Control

@onready var dialog: Control = %Dialog

func _process(delta: float) -> void:
	if !dialog.visible:
		get_tree().change_scene_to_file("res://scene/main_menu.tscn")
