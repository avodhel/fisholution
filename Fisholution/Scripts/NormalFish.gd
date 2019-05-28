extends "res://Scripts/Fish.gd"

signal hit #when something hits our fish
signal my_fish_eaten(by_who) #when my fish eaten, increase score for fish who ate our fish

export (float) var speed = 3
export (float) var min_scale = 1.5
export (float) var max_scale = 2.5

onready var animation = $Sprite/AnimationPlayer

var current_speed
var die_effect

func _ready():
	self.connect("area_entered", self, "_on_Fish_area_entered")
	current_speed = speed
	_rand_scale(min_scale, max_scale)

func _process(delta):
	pc_control(self, animation)
	move(delta, self, speed)

func _input(event):
	mobile_control(event, self, animation)

func _on_Fish_area_entered(area):
	if area.is_in_group("enemy") and area.is_in_group("badfish"): # if enemy is a fish
		#badfish's kind kontrol
		var same_fish_control = false
		if Global.fish_no != area.badfish_no:
			same_fish_control = false
		elif Global.fish_no == area.badfish_no:
			same_fish_control = true

		if !same_fish_control: # if badfish is not same kind fish
			if area.scale >= (scale + Vector2(0.7, 0.7)): #if badfish is bigger than our fish
				_die() #our fish died
				emit_signal("my_fish_eaten", area)
#			elif (area.scale + Vector2(0.5, 0.5)) <= scale: #badfish is smaller than our fish
#				area.hide()
#				area.queue_free()
	#			nom_sound.play()
	elif area.is_in_group("enemy") and area.is_in_group("not_fish"): #if enemy is not fish, we can't eat it but they can eat us
		if area.scale >= (scale + Vector2(0.7, 0.7)): #if enemy is bigger than our fish
			_die() #our fish died

func _die():
	self.speed = 0
	die_effect.start()
	emit_signal("hit") #game will know fish died :(

func _on_die_effect_tween_completed(object, key):
	call_deferred("set_monitoring", false) #Using call_deferred() allows us to have Godot wait to disable the shape until it’s safe to do so.

func respawn(control):
	if control:
		show()
		call_deferred("set_monitoring", true)
		_rand_scale(min_scale, max_scale)
		control = false

func _rand_scale(min_scale, max_scale):
	var rand_scale = rand_range(min_scale, max_scale)
	self.scale = Vector2(rand_scale, rand_scale)























