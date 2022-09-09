extends "res://Scripts/Gun.gd"

func _ready():
	config()

func config():
	damage = 10
	frt.wait_time = 0.1
	spread = 0.03
	intensity = 10
	fire_type = ["semi", "auto"]
	cur_type = 1
