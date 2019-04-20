extends Node2D

onready var sprite = $Sprite
onready var animation = $Sprite/AnimationPlayer

var rand_scale
var rand_vector

func _ready():
	if is_in_group("common_sea_weed"):
		rand_scale = rand_range(0.6, 3)
		rand_vector = Vector2(rand_scale, rand_scale)
		sprite.scale = rand_vector
		sprite.modulate = Color(rand_range(0,1), rand_range(0,1), rand_range(0,1)) #random color
	elif is_in_group("rare_sea_weed"):
		rand_scale = rand_range(0.8, 1.5)
		rand_vector = Vector2(rand_scale, rand_scale)
		sprite.scale = rand_vector
	elif is_in_group("sea_shell"):
		sprite.frame = rand_range(0, sprite.hframes - 1) #chose random shell
		rand_scale = rand_range(0.4, 0.9)
		rand_vector = Vector2(rand_scale, rand_scale)
		sprite.scale = rand_vector
#		sprite.modulate = Color(rand_range(0, 1), rand_range(0,1), rand_range(0,1)) #random color
		rotation_degrees = rand_range(-360, 360) # Add some randomness to the rotation.
	elif is_in_group("sea_rock"):
		sprite.frame = rand_range(0, sprite.hframes - 1) #chose random rock
		rand_scale = rand_range(0.8, 2.5)
		rand_vector = Vector2(rand_scale, rand_scale)
		sprite.scale = rand_vector

func _process(delta):
	if animation != null:
		animation.play("idle")