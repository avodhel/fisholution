extends RigidBody2D

export (int) var min_speed
export (int) var max_speed

onready var sprite = $Sprite
onready var body_coll = $bodyColl
onready var animation = $Sprite/AnimationPlayer

var rand_scale
var rand_vector
var sprite_scale

func _ready():
	rand_scale = rand_range(0.5, 4.5)
	rand_vector = Vector2(rand_scale, rand_scale)
	sprite.scale = rand_vector
	body_coll.scale = rand_vector
	sprite_scale = sprite.scale

func _process(delta):
	animation.play("right")

func _on_VisibilityNotifier2D_screen_exited():
	call_deferred('free')

