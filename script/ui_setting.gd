extends Panel

@onready var slider_music: HSlider = $CardSetting/HSlideMusic
@onready var slider_sfx: HSlider = $CardSetting/HSliderSoundFX

func _ready():
	# Hubungkan slider
	slider_music.value_changed.connect(_on_h_slide_music_changed)
	slider_sfx.value_changed.connect(_on_h_slider_sound_fx_changed)

	# Load setting
	slider_music.value = load_music_volume()
	slider_sfx.value = load_sfx_volume()

	# Terapkan volume saat game dibuka
	_on_h_slide_music_changed(slider_music.value)
	_on_h_slider_sound_fx_changed(slider_sfx.value)


# ==========================
# MUSIC
# ==========================
func _on_h_slide_music_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Music")

	if value <= 0:
		AudioServer.set_bus_volume_db(bus_index, -80)
	else:
		AudioServer.set_bus_volume_db(
			bus_index,
			linear_to_db(value / 100.0)
		)

	save_music_volume(value)


# ==========================
# SFX
# ==========================
func _on_h_slider_sound_fx_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("SFX")

	if value <= 0:
		AudioServer.set_bus_volume_db(bus_index, -80)
	else:
		AudioServer.set_bus_volume_db(
			bus_index,
			linear_to_db(value / 100.0)
		)

	save_sfx_volume(value)


# ==========================
# SAVE
# ==========================
func save_music_volume(value: float) -> void:
	var config = ConfigFile.new()

	config.load("user://settings.cfg")
	config.set_value("audio", "music", value)
	config.save("user://settings.cfg")


func save_sfx_volume(value: float) -> void:
	var config = ConfigFile.new()

	config.load("user://settings.cfg")
	config.set_value("audio", "sfx", value)
	config.save("user://settings.cfg")


# ==========================
# LOAD
# ==========================
func load_music_volume() -> float:
	var config = ConfigFile.new()

	if config.load("user://settings.cfg") == OK:
		return config.get_value("audio", "music", 50.0)

	return 50.0


func load_sfx_volume() -> float:
	var config = ConfigFile.new()

	if config.load("user://settings.cfg") == OK:
		return config.get_value("audio", "sfx", 50.0)

	return 50.0
