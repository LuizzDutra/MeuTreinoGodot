extends StaticBody2D

onready var col_box = $CollisionShape2D
onready var hurtbox = $hurtbox
onready var sprite = $Sprite
onready var particles = $impact
onready var timer = $Timer
onready var bar = $bar

var hp_max = 100
var hp = hp_max
var prev_col = []

func hit(damage):
	hp -= damage
	bar.get_node("red").rect_scale.x = float(hp)/float(hp_max)
	if hp <= 0:
		destroy()

func destroy():
	sprite.visible = false
	bar.visible = false
	hurtbox.monitoring = false
	col_box.set_disabled(true)
	particles.emitting = true
	particles.color = sprite.get_node("ColorRect").color
	timer.wait_time = particles.lifetime
	timer.start()

func _on_hurtbox_area_entered(area):
	if not area in prev_col and area.name == "hitbox":
		hit(area.get_parent().damage)
		prev_col.append(area)


func _on_Timer_timeout():
	queue_free()
