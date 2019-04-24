extends Node2D

onready var sprite = $Sprite
onready var animation = $Sprite/AnimationPlayer

var rand_scale
var rand_vector

func _ready():
	_chose_object()

func _process(delta):
	_play_anim()
		
func _chose_object():
	if is_in_group("sea_weed") and is_in_group("common_sea_object"):
		_rand_scale(0.6, 3)
		sprite.scale = rand_vector
		sprite.modulate = Color(rand_range(0,1), rand_range(0,1), rand_range(0,1)) #random color
	elif is_in_group("sea_weed") and is_in_group("rare_sea_object"):
		_rand_scale(0.8, 1.5)
		sprite.scale = rand_vector
	elif is_in_group("sea_shell"):
		sprite.frame = rand_range(0, sprite.hframes - 1) #chose random shell
		_rand_scale(0.4, 0.9)
		sprite.scale = rand_vector
		rotation_degrees = rand_range(-360, 360) # Add some randomness to the rotation.
	elif is_in_group("sea_rock"):
		sprite.frame = rand_range(0, sprite.hframes - 1) #chose random rock
		_rand_scale(0.8, 2.5)
		sprite.scale = rand_vector
	elif is_in_group("starfish"):
		_rand_scale(0.7, 1.85)
		sprite.scale = rand_vector
		rotation_degrees = rand_range(-65, 65)
		
func _rand_scale(min_scale, max_scale):
		rand_scale = rand_range(min_scale, max_scale)
		rand_vector = Vector2(rand_scale, rand_scale)
		return rand_vector

func _play_anim():
	if animation != null:
		animation.play("idle")