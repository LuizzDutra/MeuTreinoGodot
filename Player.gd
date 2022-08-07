extends KinematicBody2D


onready var animationPlayer = $AnimationPlayer
onready var bodyParts = $BodyParts

func _ready():
	changeHeadModulate(Color(1,1,1))


const head_qnt = 11
const body_qnt = 8
const leg_qnt = 3

var head_select = 0 setget changeHead
var body_select = 0 setget changeBody
var leg_select = 0 setget changeLeg

var head_modulate = Color(1, 1, 1) setget changeHeadModulate

var animation_arr = ["IdleRight", "WalkRight"]
var cur_anim = 0


func _process(delta):
	animationPlayer.play(animation_arr[cur_anim])

func changeHead(n):
	head_select = n
	bodyParts.get_node("Head").frame_coords.y = head_select % head_qnt + 1
	
func changeBody(n):
	body_select = n
	bodyParts.get_node("Body").frame_coords.y = body_select % body_qnt + 1

func changeLeg(n):
	leg_select = n
	bodyParts.get_node("Legs").frame_coords.y = leg_select % leg_qnt + 1

func randomizedSelection():
	changeHead(int(rand_range(0, head_qnt)))
	changeBody(int(rand_range(0, body_qnt)))
	changeLeg(int(rand_range(0, leg_qnt)))
	
func changeHeadModulate(n: Color):
	head_modulate = n
	bodyParts.get_node("Head").modulate = n

func _on_Head_pressed():
	changeHead(head_select+1)
	
func _on_Body_pressed():
	changeBody(body_select+1)

func _on_Legs_pressed():
	changeLeg(leg_select+1)


func _on_Random_pressed():
	randomizedSelection()

func _on_Animation_pressed():
	cur_anim += 1
	cur_anim = cur_anim % len(animation_arr)
