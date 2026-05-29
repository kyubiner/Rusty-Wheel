extends Control

@onready var rich_text_label: RichTextLabel = $Panel2/Monolog

@export var dialogues = []
var index = 0

var typing_speed := 0.1

func _input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_accept"):
		next_text()

func _ready() -> void:
	start_dialogue(dialogues)

func start_dialogue(texts):
	dialogues = texts
	index = 0
	visible = true
	show_text()

func show_text():
	rich_text_label.text = dialogues[index]
	rich_text_label.visible_characters = 0
	type_text()

func type_text() -> void:
	for i in rich_text_label.text.length():
		rich_text_label.visible_characters += 1
		await get_tree().create_timer(typing_speed).timeout

func next_text():
	index += 1
	if index >= dialogues.size():
		end_dialogue()
	else:
		show_text()

func end_dialogue():
	visible = false
