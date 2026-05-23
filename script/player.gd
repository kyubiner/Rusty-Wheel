extends CharacterBody2D
#@onready var ladder: Area2D = $"../GroupLadder/Ladder"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var on_ladder = false
#var gravity = 200.0
var direction : float

var wind_force = 0.0

func _ready() -> void:
	CheckPointManager.Checkpoint_position = global_position
	CheckPointManager.Checkpoint_rotation = global_rotation
	velocity = Vector2.ZERO
	animated_sprite_2d.play("idle")

func _physics_process(delta: float) -> void:

	# tambah animasi run dan idle
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "run"
	else:
		animated_sprite_2d.animation = "idle"

	# gravity
	#if not is_on_floor():
		#velocity += get_gravity() * delta
		
	if on_ladder:
		velocity.y = Input.get_axis("move_up", "move_down") * 250
	else:
		if not is_on_floor():
			#velocity.y += gravity * delta
			velocity += get_gravity() * delta
			
	# input kiri kanan
	direction = Input.get_axis("move_left", "move_right")

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
