extends KinematicBody2D

var dir = Vector2.ZERO
var velocity = Vector2.ZERO
var speed = 300
var accel = 1200
var friction = 800
onready var gun = $Gun
onready var sprite = $Sprite


func _process(delta):
	dir = Vector2.ZERO
	
	if Input.is_key_pressed(KEY_D):
		dir.x = 1
	if Input.is_key_pressed(KEY_A):
		dir.x = -1
	if Input.is_key_pressed(KEY_W):
		dir.y = -1
	if Input.is_key_pressed(KEY_S):
		dir.y = 1
	
	velocity += dir * accel * delta
	velocity = velocity.clamped(speed)
	
	if dir == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide(velocity)
	
	var g_rotation = get_global_mouse_position() - gun.global_position
	g_rotation = rad2deg(atan2(g_rotation[1], g_rotation[0]))
	if g_rotation < 0:
		g_rotation += 360
	if g_rotation > 90 and g_rotation < 270:
		gun.get_node("Sprite").flip_v = true
	else:
		gun.get_node("Sprite").flip_v = false
	gun.rotation_degrees = g_rotation
	
	if Input.is_action_pressed("shoot"):
		gun.tgrpull()
	
	if Input.is_action_just_released("shoot"):
		gun.tgrrelease()
		
	if Input.is_action_just_pressed("ui_down"):
		gun.cur_type += 1

