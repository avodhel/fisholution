extends Path2D

export var speed = 20

var direction = 1 #left or right
var rand_scale
var rand_vector

onready var path_follow = $PathFollow2D
onready var sprite = $PathFollow2D/Sprite
onready var anim = $PathFollow2D/Sprite/AnimationPlayer

func _ready():
	_chose_object()
	randomize()
	direction = 1 if rand_range(0,100) > 50 else -1
	path_follow.unit_offset = rand_range(0, 1) #rand location on path
	
func _process(delta):
	_move_on_path(delta)
	anim.play("idle")
	
func _chose_object():
	if is_in_group("crab"):
		speed = rand_range(15, 25)
		_rand_scale(0.9, 1.5)
		sprite.scale = rand_vector
	elif is_in_group("sea_snail"):
		speed = rand_range(5,15)
		_rand_scale(0.6, 1.1)
		sprite.scale = rand_vector
	
func _move_on_path(delta):
	if is_in_group("sea_snail"):
		if direction == 1:
			sprite.set_flip_h(false)
		else:
			sprite.set_flip_h(true)
	
	path_follow.offset += speed * direction * delta
	if direction > 0 and path_follow.unit_offset > 0.99: #if moving right
		direction = -1
	elif direction < 0 and path_follow.unit_offset < 0.01: #if moving left 
		direction = 1

func _rand_scale(min_scale, max_scale):
		rand_scale = rand_range(min_scale, max_scale)
		rand_vector = Vector2(rand_scale, rand_scale)
		return rand_vector