extends Area2D

@export var push_force = 20000.0
@export var active_time = 4.0
@export var inactive_time = 2.0

@onready var particles = $GPUParticles2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_active = true
var timer = 0.0


func _physics_process(delta):

	timer += delta

	# kondisi aktif
	if is_active:

		# nyalakan partikel & animasi
		particles.emitting = true
		animated_sprite_2d.play()

		# dorong player
		for body in get_overlapping_bodies():
			if body.has_method("apply_wind_force"):
				body.apply_wind_force(push_force)

		# timer aktif
		if timer >= active_time:
			is_active = false
			timer = 0.0

	# kondisi mati
	else:

		# matikan partikel & animasi 
		particles.emitting = false
		animated_sprite_2d.stop()

		# timer mati
		if timer >= inactive_time:
			is_active = true
			timer = 0.0
