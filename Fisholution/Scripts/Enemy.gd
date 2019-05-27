extends Area2D

signal fish_died(which_fish)
signal fish_eaten(by_who)

export (int) var number_of_octopus = 3
export (int) var number_of_jellyfish = 3
export (int) var number_of_turtle = 2
export (float) var min_scale = 0.5
export (float) var max_scale = 4.5
export (float) var min_speed = 1.8
export (float) var max_speed = 3.8

onready var sprite = $Sprite
onready var animation = $Sprite/AnimationPlayer
onready var die_effect = $die_effect

var rand_scale
var rand_vector
var velocity = Vector2()
var direction 
var speed

var badfish_no

func _ready():
	_prepare_badfish()
	_detect_badfish()
	if self.is_in_group("not_fish"):
		_choose_different_not_fish()
	if !self.is_in_group("not_fish"):
		Global.die_effect(die_effect, self) # get settings for die effect

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
#	if Global.which_mode == "natural_selection":
#		if self.is_in_group("badfish"):
#			emit_signal("fish_died", self)
#		self.call_deferred("free")
	if self.is_in_group("not_fish"):
		self.call_deferred("set_monitoring", false)
		self.call_deferred("set_monitorable", false)
		self.call_deferred("free")
	if Global.which_mode == "fisholution":
		self.call_deferred("set_monitoring", false)
		self.call_deferred("set_monitorable", false)
		self.call_deferred("free")

func _on_Enemy_area_entered(area):
	if self.is_in_group("badfish") and area.is_in_group("badfish"): #between fishes
		if self.badfish_no != area.badfish_no: #if badfishes are not same kind
			if area.scale > scale:
				_fish_died(area)
	elif self.is_in_group("badfish") and area.is_in_group("my_fish"): #between fishes and my fish
		if self.badfish_no != Global.fish_no:
			if area.scale > scale:
				_fish_died(area)
	elif self.is_in_group("badfish") and area.is_in_group("not_fish"): #between fishes and not_fishes
		if area.scale > scale:
			_fish_died(area)

func _fish_died(area):
#		print(self.name + " eaten by " + area.name)
		self.speed = 0
		die_effect.start()
		emit_signal("fish_died", self)
		emit_signal("fish_eaten", area)

func _on_die_effect_tween_completed(object, key):
	self.call_deferred("set_monitoring", false)
	self.call_deferred("set_monitorable", false)
	self.call_deferred("free")

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

func _choose_different_not_fish():
	var rand_not_fish = []
	var number = 0
	var number_of_enemy_not_fish

	if self.is_in_group("octopus"):
		number_of_enemy_not_fish = number_of_octopus
	elif self.is_in_group("jellyfish"):
		number_of_enemy_not_fish = number_of_jellyfish
	elif self.is_in_group("turtle"):
		number_of_enemy_not_fish = number_of_turtle

	for counter in range(number_of_enemy_not_fish):
		rand_not_fish.append(number)
		number += 32

	randomize()
	var rand_frame = rand_not_fish[randi()%rand_not_fish.size()]
	sprite.region_rect.position.y = rand_frame
#	print(rand_not_fish)
#	print(rand_frame)



