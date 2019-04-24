extends Area2D

signal hit #when something hits our fish
signal xp_gained # when fish eat little fish

export (int) var speed = 200

onready var sprite = $Sprite
onready var animation = $Sprite/AnimationPlayer
onready var bubble = $Bubble
onready var nom_sound = $Nom
onready var fish_cam = $FishCam

var velocity = Vector2()
var screensize
var rand_gain_scale

func _ready():
	hide() # invisible fish when the game first start
	screensize = get_viewport_rect().size

func _process(delta):
	velocity = Vector2()

	if Input.is_action_pressed("ui_right"):
        velocity.x += 1
        animation.play("right")
	if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
        animation.play("left")
	if Input.is_action_pressed("ui_down"):
        velocity.y += 1
        animation.play("down")
	if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
        animation.play("up")

	if velocity.length() > 0:
        bubble.emitting = true
        velocity = velocity.normalized() * speed
	else:
        bubble.emitting = false
        
	position += velocity * delta

func _on_Fish_body_entered(body): #when something hit fish's collision this func works
	if body.is_in_group("enemy") and body.is_in_group("badfish"): # if enemy is a fish
		if body.sprite_scale >= (scale + Vector2(0.7, 0.7)): #if badfish is bigger than our fish
			_die() #our fish died
		elif (body.sprite_scale + Vector2(0.5, 0.5)) <= scale: #badfish is smaller than our fish
			body.hide()
			body.queue_free()
			emit_signal("xp_gained")
			nom_sound.play()
		else:
			print(scale)
			print(body.sprite.scale)
	elif body.is_in_group("enemy") and body.is_in_group("not_fish"): #if enemy is not fish, we can't eat it but they can eat us
		if body.sprite_scale >= (scale + Vector2(0.7, 0.7)): #if enemy is bigger than our fish
			_die() #our fish died

func _die():
	hide()
	emit_signal("hit") #game will know fish died
	call_deferred("set_monitoring", false) #Using call_deferred() allows us to have Godot wait to disable the shape until it’s safe to do so.

func start(pos):
	position = pos
	show()
	monitoring = true

func _on_HUD_fisholution_up(): # when fisholution level increase
	sprite.region_rect.position.y += 128 # fish evolution (changing text region's position)
	if scale <= Vector2(2.6, 2.6):
		rand_gain_scale = rand_range(0.04, 0.1)
		scale += Vector2(rand_gain_scale, rand_gain_scale) # our fish grows up
#	fish_cam.zoom += Vector2(0.1, 0.1)
