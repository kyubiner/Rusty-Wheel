extends Control
@onready var ui_exit: Panel = $UIExit
@onready var ui_credit: Panel = $UICredit
@onready var mainAudio: AudioStreamPlayer2D = $GroupAudio/mainAudio
@onready var hoverAudio: AudioStreamPlayer2D = $GroupAudio/hoverAudio
@onready var clickAudio: AudioStreamPlayer2D = $GroupAudio/clickAudio

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mainAudio.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# buka panel credit
func _on_button_credit_pressed() -> void:
	play_click()
	ui_credit.visible = true
# tutup panel credit
func _on_button_back_pressed() -> void:
	play_click()
	ui_credit.visible = false
	
# buka panel exit
func _on_button_exit_pressed():
	play_click()
	ui_exit.visible = true
	
# tutup panel exit
func _on_button_no_pressed():
	play_click()
	ui_exit.visible = false

# keluar dari game
func _on_button_yes_pressed():
	play_click()
	get_tree().quit()

# masuk game
func _on_button_start_pressed() -> void:
	play_click()
	get_tree().change_scene_to_file("res://scene/main.tscn")
	
func play_hover():
	hoverAudio.play()

func play_click():
	clickAudio.play()


func _on_button_start_mouse_entered() -> void:
	play_hover()
	
func _on_button_credit_mouse_entered() -> void:
	play_hover()

func _on_button_exit_mouse_entered() -> void:
	play_hover()
