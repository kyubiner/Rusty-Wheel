extends Control

@onready var tutorial: Control = $"."
@onready var card_tutorial: Sprite2D = $CardTutorial
@onready var card_tutorial_2: Sprite2D = $CardTutorial2

var tutorial_index := 1

func _input(event):
	if event.is_action_pressed("ui_accept") and tutorial.visible:
		if tutorial_index == 1:
			card_tutorial.visible = false
			card_tutorial_2.visible = true
			tutorial_index = 2
		elif tutorial_index == 2:
			card_tutorial_2.visible = false
			tutorial_index = 2
			get_tree().paused = false
			tutorial.visible = false
