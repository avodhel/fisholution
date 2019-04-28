extends Area2D

signal hit #when something hits our fish
signal xp_gained # when fish eat little fish

export (float) var speed = 3

onready var sprite = $Sprite
onready var animation = $Sprite/AnimationPlayer
onready var bubble = $Bubble
onready var nom_sound = $Nom
onready var fish_cam = $FishCam

var velocity = Vector2()
var screensize
var rand_gain_scale
var center
var up_center
var down_center
var left_center
var right_center
var distance_x
var distance_y

func _ready():
	hide() # invisible fish when the game first start
	screensize = get_viewport_rect().size
	center = get_viewport_rect().size / 2 #center of the screen
	up_center = center / Vector2(1, 2)
	down_center = center + Vector2(0, up_center.y)
	left_center = center / Vector2(2, 1)
	right_center = center + Vector2(left_center.x, 0)

func _process(delta):
	_pc_control()
	_move(delta)

func _input(event):
	_mobile_control(event)

func _mobile_control(event):
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.is_pressed():
		if event.position.x > 120 and event.position.x < 360 and event.position.y < up_center.y : #up
			velocity = Vector2(0, 0)
			velocity.y -= 1
			animation.play("up")
		if event.position.x > 120 and event.position.x < 360 and event.position.y > down_center.y : #down
			velocity = Vector2(0, 0)
			velocity.y += 1
			animation.play("down")
		if event.position.x < left_center.x and  event.position.y > 180 and event.position.y < 540 : # left
			velocity = Vector2(0, 0)
			velocity.x -= 1
			animation.play("left")
		if event.position.x > right_center.x and  event.position.y > 180 and event.position.y < 540: # right
			velocity = Vector2(0, 0)
			velocity.x += 1
			animation.play("right")
		if event.position.x < 120 and event.position.y < 180: #up-left
			velocity = Vector2(0, 0)
			velocity.y -= 1
			velocity.x -= 1
			animation.play("up-left")
		if event.position.x > 360 and event.position.y < 180: #up-right
			velocity = Vector2(0, 0)
			velocity.y -= 1
			velocity.x += 1
			animation.play("up-right")
		if event.position.x < 120 and event.position.y > 540: #down-left
			velocity = Vector2(0, 0)
			velocity.y += 1
			velocity.x -= 1
			animation.play("down-left")
		if event.position.x > 360 and event.position.y > 540: #down-right
			velocity = Vector2(0, 0)
			velocity.y += 1
			velocity.x += 1
			animation.play("down-right")
		if event.position.x > 120 and event.position.x < 240 and event.position.y > 180 and event.position.y < 360: #up or left?
			distance_y = event.position.y - up_center.y
			distance_x = event.position.x - left_center.x
			if distance_x < distance_y: # left
				velocity = Vector2(0, 0)
				velocity.x -= 1
				animation.play("left")
			else: # up
				velocity = Vector2(0, 0)
				velocity.y -= 1
				animation.play("up")
		if event.position.x > 240 and event.position.x < 360 and event.position.y > 180 and event.position.y < 360: #up or right?
			distance_y = event.position.y - up_center.y
			distance_x = right_center.x - event.position.x
			if distance_x < distance_y: # right
				velocity = Vector2(0, 0)
				velocity.x += 1
				animation.play("right")
			else: # up
				velocity = Vector2(0, 0)
				velocity.y -= 1
				animation.play("up")
		if event.position.x > 120 and event.position.x < 240 and event.position.y > 360 and event.position.y < 540: #down or left?
			distance_y = down_center.y - event.position.y
			distance_x = event.position.x - left_center.x
			if distance_x < distance_y: # left
				velocity = Vector2(0, 0)
				velocity.x -= 1
				animation.play("left")
			else: # down
				velocity = Vector2(0, 0)
				velocity.y += 1
				animation.play("down")
		if event.position.x > 240 and event.position.x < 360 and event.position.y > 360 and event.position.y < 540: #down or right?
			distance_y = down_center.y - event.position.y
			distance_x = right_center.x - event.position.x
			if distance_x < distance_y: # right
				velocity = Vector2(0, 0)
				velocity.x += 1
				animation.play("right")
			else: # down
				velocity = Vector2(0, 0)
				velocity.y += 1
				animation.play("down")

func _pc_control():
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(0, 0)
		velocity.y -= 1
		animation.play("up")
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(0, 0)
		velocity.y += 1
		animation.play("down")
	if Input.is_action_pressed("ui_left"):
		velocity = Vector2(0, 0)
		velocity.x -= 1
		animation.play("left")
	if Input.is_action_pressed("ui_right"):
		velocity = Vector2(0, 0)
		velocity.x += 1
		animation.play("right")
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left") :
		velocity = Vector2(0, 0)
		velocity.y -= 1
		velocity.x -= 1
		animation.play("up-left")
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right") :
		velocity = Vector2(0, 0)
		velocity.y -= 1
		velocity.x += 1
		animation.play("up-right")
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left") :
		velocity = Vector2(0, 0)
		velocity.y += 1
		velocity.x -= 1
		animation.play("down-left")
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right") :
		velocity = Vector2(0, 0)
		velocity.y += 1
		velocity.x += 1
		animation.play("down-right")

	if velocity.length() > 0:
		bubble.emitting = true
#		velocity = velocity.normalized() * speed
	else:
		bubble.emitting = false

func _move(delta):
	position += (velocity * delta ).normalized() * speed
	
func stop(condition): # stop fish when game over and move fish again when game restart
	if condition:
		speed = 0
	else:
		speed = 3

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
	emit_signal("hit") #game will know fish died :(
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
