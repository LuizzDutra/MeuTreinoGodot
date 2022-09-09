extends Node2D

var proj_scene = load("res://Scenes/Projectile.tscn")
onready var gunshot = $gunshot
onready var tip = $tip
onready var tip2 = $tip2
onready var frt = $firerate
onready var tgr = $trigger
onready var muzzle = $Muzzle
onready var mzltimer = $muzzletimer
onready var empty = $empty_sound

var mag_size = 30
var mag_hold = 0 setget change_mag
var fire_type = ["semi", "auto"]
var cur_type = 1 setget changeFireType
var able = true
var tgractive = false
var tgrsoundplayed = false
var spread = 0.05
var intensity = 10
var bltCount = 1
var damage = 10
signal shot(n)

func _ready():
	mzltimer.wait_time = 0.05

func _process(_delta):
	if tgractive:
		if fire_type[cur_type] == "semi":
			if able:
				shoot()
				able = false
		if fire_type[cur_type] == "auto":
			if able:
				shoot()
				able = false
				frt.start()


func tgrpull():
	tgractive = true


func tgrrelease():
	tgractive = false
	tgrsoundplayed = false
	if fire_type[cur_type] == "semi" and tgr.is_stopped():
		tgr.start()


func shoot():
	if mag_hold > 0:
		for _i in range(bltCount):
			var projectile = proj_scene.instance()
			projectile.dir = Vector2(tip2.global_position - tip.global_position).normalized()
			projectile.dir = Vector2(projectile.dir + Vector2(rand_range(-spread, spread), rand_range(-spread, spread))).normalized()
			projectile.global_position = tip.global_position
			projectile.damage = damage
			get_parent().get_parent().add_child(projectile)
		gunshot.play()
		muzzle.visible = true
		mzltimer.start()
		change_mag(mag_hold-1)
		emit_signal("shot", intensity)
	elif !tgrsoundplayed:
		empty.play()
		tgrsoundplayed = true


func changeFireType(n):
	cur_type = n % len(fire_type)

func reload():
	change_mag(mag_hold + mag_size)

func change_mag(n):
	if n > mag_size + 1:
		mag_hold = mag_size + 1
	elif n < 0:
		mag_hold = 0
	else:
		mag_hold = n

func _on_trigger_timeout():
	able = true

func _on_firerate_timeout():
	able = true

func _on_muzzletimer_timeout():
	muzzle.visible = false
