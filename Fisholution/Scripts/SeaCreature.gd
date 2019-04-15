extends Node2D

onready var animation = $Sprite/AnimationPlayer

func _ready():
	var rand_scale = rand_range(0.3, 2)
	var rand_vector = Vector2(rand_scale, rand_scale)
	$Sprite.scale = rand_vector

func _process(delta):
	animation.play("idle")