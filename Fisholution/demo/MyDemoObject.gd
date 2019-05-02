extends Area2D

var velocity = Vector2()

func _ready():
	pass

func _process(delta):
	_control(delta)

func _control(delta):
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(0, 0)
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(0, 0)
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity = Vector2(0, 0)
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity = Vector2(0, 0)
		velocity.x += 1
	_move(delta)

func _move(delta):
	position += (velocity * delta ).normalized() * 5