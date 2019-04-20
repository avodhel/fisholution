extends Node2D

onready var sprite = $Sprite
onready var animation = $Sprite/AnimationPlayer

func _ready():
	if is_in_group("common_sea_weed"):
		var rand_scale = rand_range(0.6, 3)
		var rand_vector = Vector2(rand_scale, rand_scale)
		sprite.scale = rand_vector
		sprite.modulate = Color(rand_range(0,1), rand_range(0,1), rand_range(0,1)) #random color
	elif is_in_group("rare_sea_weed"):
		var rand_scale = rand_range(0.6, 1.5)
		var rand_vector = Vector2(rand_scale, rand_scale)
		sprite.scale = rand_vector

func _process(delta):
	animation.play("idle")