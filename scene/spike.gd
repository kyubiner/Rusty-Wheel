extends Area2D

# jadi intruksi dari spike ini yaitu dimana durinya delay (wait_time) 
# dulu kemudian baru melakukan intruksi dari naik turun dengan waktu (speed) 
# dan dengan ketinggian (height)
# dan terus looping (delay -> (naik-turun)) untuk siklusnya

@export var height := 50
@export var speed := 2.0
@export var wait_time := 1.5  # delay tiap loop

var start_y
var time := 0.0

func _ready():
	start_y = position.y

func _process(delta):
	time += delta
	
	var cycle_duration = wait_time + (PI / speed)
	var t = fmod(time, cycle_duration)

	if t < wait_time:
		# fase diam (delay)
		position.y = start_y
	else:
		# fase gerak
		var move_t = (t - wait_time) * speed
		position.y = start_y - abs(sin(move_t)) * height
