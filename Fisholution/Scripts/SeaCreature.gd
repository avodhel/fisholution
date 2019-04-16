extends Node2D

onready var sprite = $Sprite
onready var animation = $Sprite/AnimationPlayer

func _ready():
	var rand_scale = rand_range(0.6, 3)
	var rand_vector = Vector2(rand_scale, rand_scale)
	sprite.scale = rand_vector
	sprite.modulate = Color(rand_range(0,1), rand_range(0,1), rand_range(0,1)) #random color

func _process(delta):
#	animation.play("idle")
	pass