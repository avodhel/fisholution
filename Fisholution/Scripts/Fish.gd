extends Area2D

signal fish_died #when something eat our fish

var velocity = Vector2()
var control_dir
var screensize
var center
var up_center
var down_center
var left_center
var right_center
var distance_x
var distance_y

var eaten_fish_count = 0

func _ready():
	_screen_points()
	Global.eaten_fish_count = eaten_fish_count

func fish_stop(condition, speed, current_speed): # stop fish when game over and move fish again when game restart
	if condition:
		speed = 0
	else:
		speed = current_speed

func _die(die_effect):
	self.speed = 0
	die_effect.start()
	emit_signal("fish_died") #game will know fish died :(

func _on_die_effect_tween_completed(object, key):
#	print("fish is free now")
	call_deferred("set_monitoring", false) #Using call_deferred() allows us to have Godot wait to disable the shape until it’s safe to do so.

#CONTROLLERS
func _screen_points():
	screensize = Vector2 (ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))
	center = screensize / 2 #center of the screen
	up_center = center / Vector2(1, 2)
	down_center = center + Vector2(0, up_center.y)
	left_center = center / Vector2(2, 1)
	right_center = center + Vector2(left_center.x, 0)

func pc_control(object, animation):
	if Input.is_action_pressed("ui_up"):
		control_dir = "up"
	if Input.is_action_pressed("ui_down"):
		control_dir = "down"
	if Input.is_action_pressed("ui_left"):
		control_dir = "left"
	if Input.is_action_pressed("ui_right"):
		control_dir = "right"
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left") :
		control_dir = "up-left"
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right") :
		control_dir = "up-right"
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left") :
		control_dir = "down-left"
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right") :
		control_dir = "down-right"
	
	_direction(control_dir, object, animation)

func mobile_control(event, object, animation):
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.is_pressed():
		if (event.position.x > screensize.x / 4) and (event.position.x < screensize.x * 3 / 4) and (event.position.y < up_center.y): #up
			control_dir = "up"
		if (event.position.x > screensize.x / 4) and (event.position.x < screensize.x * 3 / 4) and (event.position.y > down_center.y): #down
			control_dir = "down"
		if (event.position.x < left_center.x) and  (event.position.y > screensize.y / 4) and (event.position.y < screensize.y * 3 / 4): # left
			control_dir = "left"
		if (event.position.x > right_center.x) and  (event.position.y > screensize.y / 4) and (event.position.y < screensize.y * 3 / 4): # right
			control_dir = "right"
		if (event.position.x < screensize.x / 4) and (event.position.y < screensize.y / 4): #up-left
			control_dir = "up-left"
		if (event.position.x > screensize.x * 3 / 4) and (event.position.y < screensize.y / 4): #up-right
			control_dir = "up-right"
		if (event.position.x < screensize.x / 4) and (event.position.y > screensize.y * 3 / 4): #down-left
			control_dir = "down-left"
		if (event.position.x > screensize.x * 3 / 4) and (event.position.y > screensize.y * 3 / 4): #down-right
			control_dir = "down-right"
		if (event.position.x > screensize.x / 4) and (event.position.x < screensize.x / 2) and (event.position.y > screensize.y / 4) and (event.position.y < screensize.y / 2): #up or left?
			distance_y = event.position.y - up_center.y
			distance_x = event.position.x - left_center.x
			if distance_x < distance_y: # left
				control_dir = "left"
			else: # up
				control_dir = "up"
		if (event.position.x > screensize.x / 2) and (event.position.x < screensize.x * 3 / 4) and (event.position.y > screensize.y / 4) and (event.position.y < screensize.y / 2): #up or right?
			distance_y = event.position.y - up_center.y
			distance_x = right_center.x - event.position.x
			if distance_x < distance_y: # right
				control_dir = "right"
			else: # up
				control_dir = "up"
		if (event.position.x > screensize.x / 4) and (event.position.x < screensize.x / 2) and (event.position.y > screensize.y / 2) and (event.position.y < screensize.y * 3 / 4): #down or left?
			distance_y = down_center.y - event.position.y
			distance_x = event.position.x - left_center.x
			if distance_x < distance_y: # left
				control_dir = "left"
			else: # down
				control_dir = "down"
		if (event.position.x > screensize.x / 2) and (event.position.x < screensize.x * 3 / 4) and (event.position.y > screensize.y / 2) and (event.position.y < screensize.y * 3 / 4): #down or right?
			distance_y = down_center.y - event.position.y
			distance_x = right_center.x - event.position.x
			if distance_x < distance_y: # right
				control_dir = "right"
			else: # down
				control_dir = "down"
		
		_direction(control_dir, object, animation)

func _direction(dir, object, animation):
	match dir:
		"up":
			velocity = Vector2(0, 0)
			velocity.y -= 1
			animation.play("move")
			object.rotation_degrees = 0
		"down":
			velocity = Vector2(0, 0)
			velocity.y += 1
			animation.play("move")
			object.rotation_degrees = 180
		"left":
			velocity = Vector2(0, 0)
			velocity.x -= 1
			animation.play("move")
			object.rotation_degrees = 270
		"right":
			velocity = Vector2(0, 0)
			velocity.x += 1
			animation.play("move")
			object.rotation_degrees = 90
		"up-left":
			velocity = Vector2(0, 0)
			velocity.y -= 1
			velocity.x -= 1
			animation.play("move")
			object.rotation_degrees = 315
		"up-right":
			velocity = Vector2(0, 0)
			velocity.y -= 1
			velocity.x += 1
			animation.play("move")
			object.rotation_degrees = 45
		"down-left":
			velocity = Vector2(0, 0)
			velocity.y += 1
			velocity.x -= 1
			animation.play("move")
			object.rotation_degrees = 225
		"down-right":
			velocity = Vector2(0, 0)
			velocity.y += 1
			velocity.x += 1
			animation.play("move")
			object.rotation_degrees = 135

func move(delta, object, speed):
	object.position += (velocity * delta ).normalized() * speed