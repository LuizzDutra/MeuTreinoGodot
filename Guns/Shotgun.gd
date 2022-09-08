extends "res://Scripts/Gun.gd"

func _ready():
	config()

func config():
	mag_size = 7
	bltCount = 7
	tgr.wait_time = 0.5
	spread = 0.15
	intensity = 25
	fire_type = ["semi"]
	cur_type = 0
