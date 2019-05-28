extends "res://Scripts/Fish.gd"

signal hit #when something hits our fish
signal xp_gained # when fish eat little fish

export (float) var speed = 3

onready var sprite = $Sprite
onready var animation = $Sprite/AnimationPlayer
onready var nom_sound = $Nom
onready var fish_cam = $FishCam
onready var die_effect = $die_effect

var rand_gain_scale
var current_speed

func _ready():
	current_speed = speed
	Global.die_effect(die_effect, self)

func _process(delta):
	pc_control(self, animation)
	move(delta, self, speed)

func _input(event):
	mobile_control(event, self, animation)

func _on_Fish_area_entered(area):
	if area.is_in_group("enemy") and area.is_in_group("badfish"): # if enemy is a fish
		if area.scale >= (scale + Vector2(0.7, 0.7)): #if badfish is bigger than our fish
			_die() #our fish died
		elif (area.scale + Vector2(0.5, 0.5)) <= scale: #badfish is smaller than our fish
#			area.hide()
#			area.queue_free()
			emit_signal("xp_gained")
			nom_sound.play()
	elif area.is_in_group("enemy") and area.is_in_group("not_fish"): #if enemy is not fish, we can't eat it but they can eat us
		if area.scale >= (scale + Vector2(0.7, 0.7)): #if enemy is bigger than our fish
			_die() #our fish died

func _die():
	self.speed = 0
	die_effect.start()
	emit_signal("hit") #game will know fish died :(

func _on_die_effect_tween_completed(object, key):
	call_deferred("set_monitoring", false) #Using call_deferred() allows us to have Godot wait to disable the shape until it’s safe to do so.

func start(pos):
	position = pos
	show()
	monitoring = true

func _on_HUD_fisholution_up(): # when fisholution level increase
	sprite.region_rect.position.y += 128 # fish evolution (changing text region's position)
	if scale <= Vector2(2.6, 2.6):
		rand_gain_scale = rand_range(0.05, 0.15)
		scale += Vector2(rand_gain_scale, rand_gain_scale) # our fish grows up

