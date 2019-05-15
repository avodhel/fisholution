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

var badfish_no

func _ready():
	_prepare_badfish()
	_detect_badfish()

func _process(delta):
	_move(delta)

func _prepare_badfish():
	randomize()
	direction = rand_range(-25, 25)
	self.rotation = direction
	rand_scale = rand_range(min_scale, max_scale)
	rand_vector = Vector2(rand_scale, rand_scale)
	scale = rand_vector
	speed = rand_range(min_speed, max_speed)
	animation.play("move")

func _move(delta):
	velocity.y -= 1
	position += ((velocity * delta).normalized() * speed).rotated(direction)

func _on_VisibilityNotifier2D_screen_exited():
#	call_deferred('free')
	pass

func _on_Enemy_area_entered(area):
	if self.is_in_group("badfish") and area.is_in_group("badfish"):
		if self.badfish_no != area.badfish_no: #if badfishes are not same kind
			if area.scale > scale:
				call_deferred("free")
				emit_signal("fish_died", self)

func _detect_badfish():
	if self.is_in_group("fish1"):
		badfish_no = 0
	elif self.is_in_group("fish2"):
		badfish_no = 1
	elif self.is_in_group("fish3"):
		badfish_no = 2
	elif self.is_in_group("fish4"):
		badfish_no = 3
	elif self.is_in_group("fish5"):
		badfish_no = 4
	elif self.is_in_group("fish6"):
		badfish_no = 5
	elif self.is_in_group("fish7"):
		badfish_no = 6
	elif self.is_in_group("fish8"):
		badfish_no = 7
	elif self.is_in_group("fish9"):
		badfish_no = 8
	elif self.is_in_group("fish10"):
		badfish_no = 9
	elif self.is_in_group("fish11"):
		badfish_no = 10
	elif self.is_in_group("fish12"):
		badfish_no = 11
	elif self.is_in_group("fish13"):
		badfish_no = 12


















