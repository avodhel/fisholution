extends Node

var fish_no = 0

var which_mode

func _ready():
	_bubbleffect("instance") #bubble transition
	_screen_points() #controllers

#FISH
func die_effect(effect, object):
	effect.interpolate_property(object, 'scale', object.get_scale(), Vector2(0, 0), 0.05, Tween.TRANS_QUAD, Tween.EASE_OUT)

#BUBBLE TRANSITION
var bubbleffect = ResourceLoader.load("res://Scenes/UI/Bubbleffect.tscn")

func _bubbleffect(condition): # bubble transition
	match condition:
		"instance":
			var instance_bubble = bubbleffect.instance()
			add_child(instance_bubble)
		"play":
			get_node("../Global/Bubbleffect").play_effect()

#CONTROLLERS
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

#SCENE MANAGER
const SCENE_PATH = "res://Scenes/"

func change_scene(scene_name):
	_bubbleffect("play") #play bubble effect between scenes
	yield(get_tree().create_timer(0.65), "timeout")
	call_deferred("_deferred_change_scene", scene_name)
	if get_tree().paused == true: # if game paused
		get_tree().paused = false # unpaused 

func _deferred_change_scene(scene_name):
	var path = SCENE_PATH + scene_name + ".tscn"
	var root = get_tree().get_root()
	var current = root.get_child(root.get_child_count() - 1)
	current.free()
	var scene_resource = ResourceLoader.load(path)
	var new_scene = scene_resource.instance()
	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)

#PLAYER DATA
const SAVE_FILE_PATH = "user://playerdata.save"

func save_highscore(score):
	if load_highscore() > score:
		return
	
	var save_file = File.new()
	save_file.open(SAVE_FILE_PATH, File.WRITE)
	var data = {
		highscore = score
	}
	save_file.store_line(to_json(data))
	save_file.close()

func load_highscore():
	var save_file = File.new()
	if !save_file.file_exists(SAVE_FILE_PATH):
		return 0
		
	var highscore
	
	save_file.open(SAVE_FILE_PATH, File.READ)
	var data  = parse_json(save_file.get_line())
	return data["highscore"]

