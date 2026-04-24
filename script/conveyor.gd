extends Area2D

@export var belt_speed := 180.0
@export var active := false
@export var move_right := true

func _physics_process(delta):
	if !active:
		return

	for body in get_overlapping_bodies():
		if body.name == "Player":
			if move_right:
				body.velocity.x += belt_speed * delta
			else:
				body.velocity.x -= belt_speed * delta