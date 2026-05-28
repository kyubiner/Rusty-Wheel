extends AnimatableBody2D

# --- Konfigurasi Obstacle ---
@export var travel_distance: float = 155.0
@export var speed_down: float = 0.2
@export var speed_up: float = 1.2
@export var delay_top: float = 1.0
@export var delay_bottom: float = 0.5

var start_pos: Vector2

@onready var impact_effect = $ImpactEffect


func _ready():
	start_pos = position
	setup_crush_logic()


func setup_crush_logic():

	var target_pos = start_pos + Vector2(0, travel_distance)

	var tween = create_tween().set_loops()

	# 1. Animasi Menghantam (Down)
	tween.tween_property(self, "position", target_pos, speed_down)\
		.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)

	# munculkan efek listrik
	tween.tween_callback(show_impact_effect)

	# 2. Jeda di bawah
	tween.tween_interval(delay_bottom)

	# 3. Animasi Kembali (Up)
	tween.tween_property(self, "position", start_pos, speed_up)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	# 4. Jeda di atas
	tween.tween_interval(delay_top)


# --- Efek Impact ---
func show_impact_effect():

	impact_effect.visible = true

	await get_tree().create_timer(0.1).timeout

	impact_effect.visible = false


# --- Deteksi Jika Player Tertindih ---
func _on_area_2d_body_entered(body):

	if body.is_in_group("player") or body.name == "Player":

		print("Player tertindih mesin!")

		body.global_position = CheckPointManager.Checkpoint_position
