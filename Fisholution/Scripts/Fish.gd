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
	if body.sprite_scale >= (scale + Vector2(0.3, 0.3)): #if badfish is bigger than our fish
		hide()
		emit_signal("hit") #game will know fish died
		call_deferred("set_monitoring", false) #Using call_deferred() allows us to have Godot wait to disable the shape until it’s safe to do so.
	else:
		body.hide()
		emit_signal("xp_gained")
		nom_sound.play()

func start(pos):
	position = pos
	show()
	monitoring = true

func _on_HUD_fisholution_up(): # when fisholution level increase
	sprite.region_rect.position.y += 128 # fish evolution (changing text region's position)
	scale += Vector2(0.05, 0.05)
#	fish_cam.zoom += Vector2(0.1, 0.1)
