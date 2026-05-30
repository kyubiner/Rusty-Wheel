extends Node2D

@onready var pause_game: Control = $Player/pause_game
@onready var dialog: Control = $Dialog
@onready var tutorial: Control = $Tutorial

func _ready() -> void:
	dialog.dialogue_finished.connect(_on_dialog_dialogue_finished)
	get_tree().paused = false
	if Global.Dialog:
		dialog.visible = true
		get_tree().paused = true
	else:
		dialog.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_game") and !Global.Dialog:
		pause_game.visible = true
		get_tree().paused = true

func _on_exit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().call_deferred(
			"change_scene_to_file",
			"res://scene/ending.tscn"
		)

func _on_dialog_dialogue_finished() -> void:
	get_tree().paused = true
	tutorial.visible = true
