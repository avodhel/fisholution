extends "res://Scripts/Fish.gd"

signal my_fish_eaten(by_who) #when my fish eaten, increase score for fish who ate our fish

#export (float) var speed = 3
export (float) var min_scale = 1.5
export (float) var max_scale = 3.5

onready var animation = $Sprite/AnimationPlayer
onready var die_effect = $die_effect

var current_speed

func _ready():
	self.connect("area_entered", self, "_on_Fish_area_entered")
	current_speed = speed
	_rand_scale(min_scale, max_scale)
	Global.die_effect(die_effect, self)

func _process(delta):
	pc_control(self, animation)
	move(delta, self, speed)

func _input(event):
	mobile_control(event, self, animation)

func _on_Fish_area_entered(area):
	if area.is_in_group("enemy") and area.is_in_group("badfish"): # if enemy is a fish
		#badfish's kind control
		var same_fish_control = false
		if Global.fish_no != area.badfish_no:
			same_fish_control = false
		elif Global.fish_no == area.badfish_no:
			same_fish_control = true

		if !same_fish_control: # if badfish is not same kind fish
			if area.scale >= (scale + Vector2(0.7, 0.7)): #if badfish is bigger than our fish
				_die(die_effect) #our fish died
				emit_signal("my_fish_eaten", area)
			elif (area.scale + Vector2(0.5, 0.5)) <= scale: #badfish is smaller than our fish
				Settings.nom_sound.play()
				eaten_fish_count += 1
				Global.eaten_fish_count = eaten_fish_count
#				print(Global.eaten_fish_count)
	elif area.is_in_group("enemy") and area.is_in_group("not_fish"): #if enemy is not fish, we can't eat it but they can eat us
		if area.scale >= (scale + Vector2(0.7, 0.7)): #if enemy is bigger than our fish
			_die(die_effect) #our fish died

func _rand_scale(min_scale, max_scale):
	var rand_scale = rand_range(min_scale, max_scale)
	self.scale = Vector2(rand_scale, rand_scale)























