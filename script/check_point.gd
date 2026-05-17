extends StaticBody2D
@onready var lampu_off: Sprite2D = $lampu_off
@onready var lampu_on: Sprite2D = $lampu_on

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lampu_off.visible = true
	lampu_on.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): 
		lampu_on.visible = true
		lampu_off.visible = false
		CheckPointManager.Checkpoint_position = body.global_position
