extends Node2D

@onready var pause_game: Control = $Player/pause_game

#func _ready() -> void:
	#get_tree().paused = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_game"):
		pause_game.visible = true
		get_tree().paused = true


func _on_exit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://scene/ending.tscn")
