extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var wind_force = 0.0


func _physics_process(delta: float) -> void:

	# tambah animasi run dan idle
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "run"
	else:
		animated_sprite_2d.animation = "idle"

	# gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# input kiri kanan
	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# efek dorongan angin
	velocity.x += wind_force * delta

	move_and_slide()

	# reset angin setelah dipakai
	wind_force = 0

	# flip karakter
	if direction == 1.0:
		animated_sprite_2d.flip_h = true
	elif direction == -1.0:
		animated_sprite_2d.flip_h = false


func apply_wind_force(force):
	wind_force = force
