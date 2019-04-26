extends Area2D

var center
var up_center
var down_center
var left_center
var right_center
var distance_x
var distance_y

var velocity = Vector2()

func _ready():
#	set_process_input(true) 
#	set_process_unhandled_input(true)
	center = get_viewport_rect().size / 2 #center of the screen
	up_center = center / Vector2(1, 2)
	down_center = center + Vector2(0, up_center.y)
	left_center = center / Vector2(2, 1)
	right_center = center + Vector2(left_center.x, 0)
	
#	print(center)
#	print(up_center)
#	print(down_center)
#	print(left_center)
#	print(right_center)

func _process(delta):
	_move()

func _unhandled_input(event):
	velocity = Vector2()
	
	if (event is InputEventMouseButton or event is InputEventScreenTouch) and event.is_pressed():
		if event.position.x > 120 and event.position.x < 360 and event.position.y < up_center.y : #up
			velocity.y -= 1
		if event.position.x > 120 and event.position.x < 360 and event.position.y > down_center.y : #down
			velocity.y += 1
		if event.position.x < left_center.x and  event.position.y > 180 and event.position.y < 540 : # left
			velocity.x -= 1
		if event.position.x > right_center.x and  event.position.y > 180 and event.position.y < 540: # right
			velocity.x += 1
		if event.position.x < 120 and event.position.y < 180: #up-left
			velocity.y -= 1
			velocity.x -= 1
		if event.position.x > 360 and event.position.y < 180: #up-right
			velocity.y -= 1
			velocity.x += 1
		if event.position.x < 120 and event.position.y > 540: #down-left
			velocity.y += 1
			velocity.x -= 1
		if event.position.x > 360 and event.position.y > 540: #down-right
			velocity.y += 1
			velocity.x += 1
		if event.position.x > 120 and event.position.x < 240 and event.position.y > 180 and event.position.y < 360: #up or left?
			distance_y = event.position.y - up_center.y
			distance_x = event.position.x - left_center.x
			if distance_x < distance_y: # left
				velocity.x -= 1
			else: # up
				velocity.y -= 1
		if event.position.x > 240 and event.position.x < 360 and event.position.y > 180 and event.position.y < 360: #up or right?
			distance_y = event.position.y - up_center.y
			distance_x = right_center.x - event.position.x
			if distance_x < distance_y: # right
				velocity.x += 1
			else: # up
				velocity.y -= 1
		if event.position.x > 120 and event.position.x < 240 and event.position.y > 360 and event.position.y < 540: #down or left?
			distance_y = down_center.y - event.position.y
			distance_x = event.position.x - left_center.x
			if distance_x < distance_y: # left
				velocity.x -= 1
			else: # down
				velocity.y += 1
		if event.position.x > 240 and event.position.x < 360 and event.position.y > 360 and event.position.y < 540: #down or right?
			distance_y = down_center.y - event.position.y
			distance_x = right_center.x - event.position.x
			if distance_x < distance_y: # right
				velocity.x += 1
			else: # down
				velocity.y += 1



	_move()
	
func _move():
		position += velocity * 0.1
		return position