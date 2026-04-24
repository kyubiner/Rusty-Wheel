extends Area2D

@export var conveyor_path : NodePath
var player_inside = false

func _process(delta):
	if player_inside and Input.is_action_just_pressed("ui_accept"):
		var conveyor = get_node(conveyor_path)
		conveyor.active = !conveyor.active

func _on_body_entered(body):
	if body.name == "Player":
		player_inside = true

func _on_body_exited(body):
	if body.name == "Player":
		player_inside = false