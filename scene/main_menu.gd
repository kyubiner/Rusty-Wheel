extends Control
@onready var ui_exit: Panel = $UIExit
@onready var ui_credit: Panel = $UICredit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# buka panel credit
func _on_button_credit_pressed() -> void:
	ui_credit.visible = true
# tutup panel credit
func _on_button_back_pressed() -> void:
	ui_credit.visible = false
	
# buka panel exit
func _on_button_exit_pressed():
	ui_exit.visible = true
	
# tutup panel exit
func _on_button_no_pressed():
	ui_exit.visible = false

# keluar dari game
func _on_button_yes_pressed():
	get_tree().quit()
