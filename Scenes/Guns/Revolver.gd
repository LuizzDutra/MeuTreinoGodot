extends Node2D

var proj_scene = load("res://Scenes/Projectile.tscn")
onready var gunshot = $gunshot
onready var tip = $tip
onready var tip2 = $tip2
onready var frt = $firerate
onready var tgr = $trigger
onready var muzzle = $Muzzle
onready var mzltimer = $muzzletimer
var fire_type = ["semi"]
var cur_type = 0 setget changeFireType
var able = true
var spread = 0.01


func tgrpull():
	if cur_type == 0:
		if able:
			shoot()
			able = false
			
	if cur_type == 1:
		if able:
			shoot()
			able = false
			frt.start()
		

func tgrrelease():
	if cur_type == 0:
		if tgr.is_stopped():
			tgr.start()
		
	

func shoot():
	var projectile = proj_scene.instance()
	projectile.dir = Vector2(tip2.global_position - tip.global_position).normalized()
	projectile.dir = Vector2(projectile.dir + Vector2(rand_range(-spread, spread), rand_range(-spread, spread))).normalized()
	projectile.global_position = tip.global_position
	gunshot.play()
	get_parent().get_parent().add_child(projectile)
	muzzle.visible = true
	mzltimer.start()


func changeFireType(n):
	cur_type = 0

func _on_trigger_timeout():
	able = true

func _on_firerate_timeout():
	able = true

func _on_muzzletimer_timeout():
	muzzle.visible = false
