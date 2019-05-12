extends Area2D

signal hit #when something hits our fish
signal xp_gained # when fish eat little fish

export (float) var speed = 3
export (float) var min_scale = 1.5
export (float) var max_scale = 2.5

onready var animation = $Sprite/AnimationPlayer

var velocity = Vector2()
var screensize
var center
var up_center
var down_center
var left_center
var right_center
var distance_x
var distance_y
var current_speed

func _ready():
	screensize = get_viewport_rect().size
	center = screensize / 2 #center of the screen
	up_center = center / Vector2(1, 2)
	down_center = center + Vector2(0, up_center.y)
	left_center = center / Vector2(2, 1)
	right_center = center + Vector2(left_center.x, 0)
	self.connect("area_entered", self, "_on_Fish_area_entered")
	current_speed = speed
	_rand_scale(min_scale, max_scale)

func _process(delta):
	_pc_control()
	_move(delta)

func _input(event):
	_mobile_control(event)

func _mobile_control(event):
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.is_pressed():
		if (event.position.x > screensize.x / 4) and (event.position.x < screensize.x * 3 / 4) and (event.position.y < up_center.y): #up
			_direction("up")
		if (event.position.x > screensize.x / 4) and (event.position.x < screensize.x * 3 / 4) and (event.position.y > down_center.y): #down
			_direction("down")
		if (event.position.x < left_center.x) and  (event.position.y > screensize.y / 4) and (event.position.y < screensize.y * 3 / 4): # left
			_direction("left")
		if (event.position.x > right_center.x) and  (event.position.y > screensize.y / 4) and (event.position.y < screensize.y * 3 / 4): # right
			_direction("right")
		if (event.position.x < screensize.x / 4) and (event.position.y < screensize.y / 4): #up-left
			_direction("up-left")
		if (event.position.x > screensize.x * 3 / 4) and (event.position.y < screensize.y / 4): #up-right
			_direction("up-right")
		if (event.position.x < screensize.x / 4) and (event.position.y > screensize.y * 3 / 4): #down-left
			_direction("down-left")
		if (event.position.x > screensize.x * 3 / 4) and (event.position.y > screensize.y * 3 / 4): #down-right
			_direction("down-right")
		if (event.position.x > screensize.x / 4) and (event.position.x < screensize.x / 2) and (event.position.y > screensize.y / 4) and (event.position.y < screensize.y / 2): #up or left?
			distance_y = event.position.y - up_center.y
			distance_x = event.position.x - left_center.x
			if distance_x < distance_y: # left
				_direction("left")
			else: # up
				_direction("up")
		if (event.position.x > screensize.x / 2) and (event.position.x < screensize.x * 3 / 4) and (event.position.y > screensize.y / 4) and (event.position.y < screensize.y / 2): #up or right?
			distance_y = event.position.y - up_center.y
			distance_x = right_center.x - event.position.x
			if distance_x < distance_y: # right
				_direction("right")
			else: # up
				_direction("up")
		if (event.position.x > screensize.x / 4) and (event.position.x < screensize.x / 2) and (event.position.y > screensize.y / 2) and (event.position.y < screensize.y * 3 / 4): #down or left?
			distance_y = down_center.y - event.position.y
			distance_x = event.position.x - left_center.x
			if distance_x < distance_y: # left
				_direction("left")
			else: # down
				_direction("down")
		if (event.position.x > screensize.x / 2) and (event.position.x < screensize.x * 3 / 4) and (event.position.y > screensize.y / 2) and (event.position.y < screensize.y * 3 / 4): #down or right?
			distance_y = down_center.y - event.position.y
			distance_x = right_center.x - event.position.x
			if distance_x < distance_y: # right
				_direction("right")
			else: # down
				_direction("down")

func _pc_control():
	if Input.is_action_pressed("ui_up"):
		_direction("up")
	if Input.is_action_pressed("ui_down"):
		_direction("down")
	if Input.is_action_pressed("ui_left"):
		_direction("left")
	if Input.is_action_pressed("ui_right"):
		_direction("right")
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left") :
		_direction("up-left")
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right") :
		_direction("up-right")
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left") :
		_direction("down-left")
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right") :
		_direction("down-right")

func _move(delta):
	self.position += (velocity * delta ).normalized() * speed

func stop(condition): # stop fish when game over and move fish again when game restart
	if condition:
		speed = 0
	else:
		speed = current_speed

func _direction(dir):
	match dir:
		"up":
			velocity = Vector2(0, 0)
			velocity.y -= 1
			animation.play("move")
			rotation_degrees = 0
		"down":
			velocity = Vector2(0, 0)
			velocity.y += 1
			animation.play("move")
			rotation_degrees = 180
		"left":
			velocity = Vector2(0, 0)
			velocity.x -= 1
			animation.play("move")
			rotation_degrees = 270
		"right":
			velocity = Vector2(0, 0)
			velocity.x += 1
			animation.play("move")
			rotation_degrees = 90
		"up-left":
			velocity = Vector2(0, 0)
			velocity.y -= 1
			velocity.x -= 1
			animation.play("move")
			rotation_degrees = 315
		"up-right":
			velocity = Vector2(0, 0)
			velocity.y -= 1
			velocity.x += 1
			animation.play("move")
			rotation_degrees = 45
		"down-left":
			velocity = Vector2(0, 0)
			velocity.y += 1
			velocity.x -= 1
			animation.play("move")
			rotation_degrees = 225
		"down-right":
			velocity = Vector2(0, 0)
			velocity.y += 1
			velocity.x += 1
			animation.play("move")
			rotation_degrees = 135

func _on_Fish_area_entered(area):
	print(area)
	if area.is_in_group("enemy") and area.is_in_group("badfish"): # if enemy is a fish
		if area.scale >= (scale + Vector2(0.7, 0.7)): #if badfish is bigger than our fish
			_die() #our fish died
		elif (area.scale + Vector2(0.5, 0.5)) <= scale: #badfish is smaller than our fish
			area.hide()
			area.queue_free()
			emit_signal("xp_gained")
#			nom_sound.play()
		else:
			print(scale)
			print(area.scale)
	elif area.is_in_group("enemy") and area.is_in_group("not_fish"): #if enemy is not fish, we can't eat it but they can eat us
		if area.scale >= (scale + Vector2(0.7, 0.7)): #if enemy is bigger than our fish
			_die() #our fish died

func _die():
	hide()
	emit_signal("hit") #game will know fish died :(
	call_deferred("set_monitoring", false) #Using call_deferred() allows us to have Godot wait to disable the shape until it’s safe to do so.

func respawn(control):
	if control:
		show()
		call_deferred("set_monitoring", true)
		_rand_scale(min_scale, max_scale)

func _rand_scale(min_scale, max_scale):
	var rand_scale = rand_range(min_scale, max_scale)
	self.scale = Vector2(rand_scale, rand_scale)























