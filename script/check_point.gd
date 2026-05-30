extends StaticBody2D
@onready var lampu_off: Sprite2D = $lampu_off
@onready var lampu_on: Sprite2D = $lampu_on
@onready var check_point: StaticBody2D = $"."
@onready var audio_stream_player_2d: AudioStreamPlayer = $AudioStreamPlayer2D
var sfx = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lampu_off.visible = true
	lampu_on.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): 
		lampu_on.visible = true
		lampu_off.visible = false
		Global.Checkpoint_position = check_point.global_position
		if sfx == false :
			audio_stream_player_2d.play()
			sfx = true
