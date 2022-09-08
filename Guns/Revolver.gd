extends "res://Scripts/Gun.gd"

func _ready():
	config()

func config():
	mag_size = 6
	tgr.wait_time = 0.2
	spread = 0.01
	intensity = 20
	fire_type = ["semi"]
	cur_type = 0

#change_mag changes because revolvers dont have a chamber
func change_mag(n):
	if n > mag_size:
		mag_hold = mag_size
	elif n < 0:
		mag_hold = 0
	else:
		mag_hold = n
