extends AnimatableBody2D

# --- Konfigurasi Obstacle ---
@export var travel_distance: float = 128.0  
@export var speed_down: float = 0.2         
@export var speed_up: float = 1.2           
@export var delay_top: float = 1.0          
@export var delay_bottom: float = 0.5       

var start_pos: Vector2

func _ready():
	start_pos = position
	setup_crush_logic()

func setup_crush_logic():
	var target_pos = start_pos + Vector2(0, travel_distance)
	var tween = create_tween().set_loops() 

	# 1. Animasi Menghantam (Down)
	tween.tween_property(self, "position", target_pos, speed_down)\
		.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	
	# 2. Jeda di bawah
	tween.tween_interval(delay_bottom)
	
	# 3. Animasi Kembali (Up)
	tween.tween_property(self, "position", start_pos, speed_up)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	# 4. Jeda di atas
	tween.tween_interval(delay_top)

# --- Deteksi Jika Player Tertindih ---
# Fungsi ini digabung agar tidak duplikat
func _on_area_2d_body_entered(body):
	# Mengecek apakah yang masuk ke area adalah player
	if body.name == "player_movement" or body.is_in_group("player") or body.name == "Player":
		print("Player tertindih mesin!")
		# Merestart scene (level) dari awal
		get_tree().reload_current_scene()
