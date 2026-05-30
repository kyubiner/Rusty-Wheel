extends StaticBody2D

@onready var utility_jump: StaticBody2D = $"."
@onready var label: Label = $"../Label"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.visible = true
		Global.Jump = true
		utility_jump.visible = false
