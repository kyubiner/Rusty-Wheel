extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer = $AudioStreamPlayer2D
@onready var pause_game: Control = $pause_game
@onready var dialog: Control = $"../Dialog"
@onready var jump: AudioStreamPlayer2D = $Jump

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var on_ladder = false
var direction : float
var wind_force = 0.0

func _ready() -> void:
	global_position = Global.Checkpoint_position
	velocity = Vector2.ZERO
	animated_sprite_2d.play("idle")

func _physics_process(delta: float) -> void:
	# tambah animasi run dan idle
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "run"
	else:
		animated_sprite_2d.animation = "idle"
	
	# gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if (Input.is_action_just_pressed("move_up") and is_on_floor()) and Global.Jump:
		jump.play()
		velocity.y = JUMP_VELOCITY
			
	if on_ladder:
		velocity.y = Input.get_axis("move_up", "move_down") * 250
		if abs(velocity.y) > 1:
			if not audio_stream_player_2d.playing:
				audio_stream_player_2d.play()
		else:
			audio_stream_player_2d.stop()
	else:
		audio_stream_player_2d.stop()
	
	# input kiri kanan
	direction = Input.get_axis("move_left", "move_right")
	
	if !dialog.visible:
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

func _on_world_bordier_body_entered(body: Node2D) -> void:
	body.global_position = Global.Checkpoint_position
