extends KinematicBody2D

var dir = Vector2.ZERO setget changedir
var velocity = Vector2.ZERO
var speed = 2400
var grav = Vector2(0, 0.98)

onready var timer = $timer
onready var impact = $impact
onready var sprite = $Sprite
var lifetime = 5
var dead = false

func _ready():
	timer.wait_time = lifetime
	timer.start()

func _process(_delta):
	if not dead:
		velocity = move_and_slide(velocity)
		if get_slide_count() > 0:
			var impact_dir = dir.bounce(get_slide_collision(0).normal)
			col_vanish(impact_dir)
		
		if timer.time_left == 0:
			vanish()
	if dead:
		if timer.time_left == 0:
			queue_free()

func changedir(n):
	dir = n
	velocity = dir * speed

func vanish():
	dir = Vector2.ZERO
	sprite.visible = false
	impact.spread = 180
	impact.emitting = true
	dead = true
	timer.stop()
	timer.wait_time = impact.lifetime
	timer.start()

func col_vanish(impact_dir):
	dir = Vector2.ZERO
	global_position = get_slide_collision(0).position
	sprite.visible = false
	impact.direction = impact_dir
	impact.emitting = true
	dead = true
	timer.stop()
	timer.wait_time = impact.lifetime
	timer.start()
