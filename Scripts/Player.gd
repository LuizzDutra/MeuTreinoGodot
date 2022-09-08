extends KinematicBody2D

var dir = Vector2.ZERO
var velocity = Vector2.ZERO
var speed = 300
var accel = 1200
var friction = 800
onready var sprite = $Sprite
onready var camera = $Camera
onready var gun = null

func _ready():
	if has_node("Gun"):
		load_gun()
		


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
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("ui_left"):
		if has_node("Gun"):
			get_node("Gun").free()
			gun = null
		add_child(load("res://Guns/AK47.tscn").instance())
		load_gun()
	
	if Input.is_action_pressed("ui_right"):
		if has_node("Gun"):
			get_node("Gun").free()
			gun = null
	
	if gun != null:
		var g_rotation = get_global_mouse_position() - gun.global_position
		g_rotation = rad2deg(atan2(g_rotation[1], g_rotation[0]))
		if g_rotation < 0:
			g_rotation += 360
		if g_rotation > 90 and g_rotation < 270:
			gun.scale.y = -1
		else:
			gun.scale.y = 1
		gun.rotation_degrees = g_rotation
	
		if Input.is_action_just_pressed("shoot"):
			gun.tgrpull()
		
		if Input.is_action_just_released("shoot"):
			gun.tgrrelease()
			
		if Input.is_action_just_pressed("ui_down"):
			gun.cur_type += 1
		
		if Input.is_action_just_pressed("ui_up"):
			gun.reload()
	
func load_gun():
	gun = $Gun
	gun.connect("shot", self, "_on_gun_shot")
	gun.position = get_node("gunHold").position

func _on_gun_shot(n):
	camera.intensity = n
	camera.start_shake()

func camera_shake():
	camera.start_shake()
