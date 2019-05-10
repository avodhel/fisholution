extends Area2D

signal fish_died(which_fish)

export (float) var min_scale = 0.5
export (float) var max_scale = 4.5
export (float) var min_speed = 0.8
export (float) var max_speed = 2.8

onready var sprite = $Sprite
onready var animation = $Sprite/AnimationPlayer

var rand_scale
var rand_vector
var velocity = Vector2()
var direction 
var speed

func _ready():
	randomize()
	direction = rand_range(-25, 25)
	self.rotation = direction
	rand_scale = rand_range(min_scale, max_scale)
	rand_vector = Vector2(rand_scale, rand_scale)
	scale = rand_vector
	speed = rand_range(min_speed, max_speed)
	animation.play("up")

func _process(delta):
	_move(delta)

func _move(delta):
	velocity.y -= 1
	position += ((velocity * delta).normalized() * speed).rotated(direction)

func _on_VisibilityNotifier2D_screen_exited():
#	call_deferred('free')
	pass

func _on_Enemy_area_entered(area):
	if area.scale > scale:
		call_deferred("free")
		emit_signal("fish_died", self)
