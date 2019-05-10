extends Area2D

export (float) var speed = 3

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

func _ready():
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
			_direction("up")
		if event.position.x > 120 and event.position.x < 360 and event.position.y > down_center.y : #down
			_direction("down")
		if event.position.x < left_center.x and  event.position.y > 180 and event.position.y < 540 : # left
			_direction("left")
		if event.position.x > right_center.x and  event.position.y > 180 and event.position.y < 540: # right
			_direction("right")
		if event.position.x < 120 and event.position.y < 180: #up-left
			_direction("up-left")
		if event.position.x > 360 and event.position.y < 180: #up-right
			_direction("up-right")
		if event.position.x < 120 and event.position.y > 540: #down-left
			_direction("down-left")
		if event.position.x > 360 and event.position.y > 540: #down-right
			_direction("down-right")
		if event.position.x > 120 and event.position.x < 240 and event.position.y > 180 and event.position.y < 360: #up or left?
			distance_y = event.position.y - up_center.y
			distance_x = event.position.x - left_center.x
			if distance_x < distance_y: # left
				_direction("left")
			else: # up
				_direction("up")
		if event.position.x > 240 and event.position.x < 360 and event.position.y > 180 and event.position.y < 360: #up or right?
			distance_y = event.position.y - up_center.y
			distance_x = right_center.x - event.position.x
			if distance_x < distance_y: # right
				_direction("right")
			else: # up
				_direction("up")
		if event.position.x > 120 and event.position.x < 240 and event.position.y > 360 and event.position.y < 540: #down or left?
			distance_y = down_center.y - event.position.y
			distance_x = event.position.x - left_center.x
			if distance_x < distance_y: # left
				_direction("left")
			else: # down
				_direction("down")
		if event.position.x > 240 and event.position.x < 360 and event.position.y > 360 and event.position.y < 540: #down or right?
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