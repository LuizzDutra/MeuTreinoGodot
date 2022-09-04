extends Camera2D

onready var timer = $Timer

var shaking = false
var intensity = 10
var time = 0.1
var dir = Vector2.ZERO

func _process(delta):
	if shaking:
		shake()
	else:
		offset = Vector2.ZERO

func shake():
	dir = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()
	offset += dir * intensity
	offset = offset.clamped(intensity)
	if timer.time_left == 0:
		shaking = false

func start_shake():
	shaking = true
	timer.wait_time = time
	timer.start()
