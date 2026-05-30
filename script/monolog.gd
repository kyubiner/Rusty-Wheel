extends Control
signal dialogue_finished

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var rich_text_label: RichTextLabel = $Panel2/Monolog
@export var dialogues = []

var index = 0
var is_typing := false
var can_advance := false
var typing_speed := 0.1

func _input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_accept"):
		if is_typing:
			rich_text_label.visible_characters = -1
			is_typing = false
		elif can_advance:
			next_text()

func _ready() -> void:
	start_dialogue(dialogues)

func start_dialogue(texts):
	dialogues = texts
	index = 0
	visible = true
	show_text()

func show_text():
	can_advance = false
	rich_text_label.text = dialogues[index]
	rich_text_label.visible_characters = 0
	is_typing = true
	await type_text()
	is_typing = false
	can_advance = true

func type_text() -> void:
	for i in range(rich_text_label.text.length()):
		if not is_typing:
			return
		rich_text_label.visible_characters += 1
		await get_tree().create_timer(typing_speed).timeout

func next_text():
	index += 1
	if index >= dialogues.size():
		end_dialogue()
	else:
		show_text()

func end_dialogue():
	Global.Dialog = false
	get_tree().paused = false
	audio_stream_player.stop()
	visible = false
	dialogue_finished.emit()
