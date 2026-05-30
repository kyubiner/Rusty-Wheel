extends Control

@onready var pause_game: Control = $"."
@onready var hover_sound_player: AudioStreamPlayer = $HoverSoundPlayer
@onready var click_sound_player: AudioStreamPlayer = $ClickSoundPlayer
@onready var player: CharacterBody2D = $".."
@onready var ui_setting: Panel = $UISetting

func play_hover():
	hover_sound_player.play()

func play_click():
	click_sound_player.play()
	await click_sound_player.finished

func _on_button_resume_mouse_entered() -> void:
	play_hover()

func _on_button_main_menu_mouse_entered() -> void:
	play_hover()

func _on_button_quit_game_mouse_entered() -> void:
	play_hover()

func _on_button_resume_pressed() -> void:
	await play_click()
	get_tree().paused = false
	pause_game.visible = false

func _on_button_main_menu_pressed() -> void:
	await play_click()
	ui_setting.visible = true

func _on_button_quit_game_pressed() -> void:
	await play_click()
	get_tree().paused = false
	pause_game.visible = false
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")

func _on_button_back_setting_pressed() -> void:
	ui_setting.visible = false
