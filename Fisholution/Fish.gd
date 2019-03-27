extends Area2D

signal hit #when something hits our fish

export (int) var speed = 200
var velocity = Vector2()
var screensize

func _ready():
	hide() # invisible fish when the game first start
	screensize = get_viewport_rect().size

func _process(delta):
	velocity = Vector2()

	if Input.is_action_pressed("ui_right"):
        velocity.x += 1
        $Sprite/AnimationPlayer.play("right")
        $CollisionShape2D.rotation_degrees = 90
#        print($CollisionShape2D.rotation_degrees)
	if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
        $Sprite/AnimationPlayer.play("left")
        $CollisionShape2D.rotation_degrees = 90
#        print($CollisionShape2D.rotation_degrees)
	if Input.is_action_pressed("ui_down"):
        velocity.y += 1
        $Sprite/AnimationPlayer.play("down")
        $CollisionShape2D.rotation_degrees = 0
#        print($CollisionShape2D.rotation_degrees)
	if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
        $Sprite/AnimationPlayer.play("up")
        $CollisionShape2D.rotation_degrees = 0
#        print($CollisionShape2D.rotation_degrees)

	if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)

func _on_Fish_body_entered(body): #when something hit fish's collision this func works
	hide()
	emit_signal("hit") #game will know fish died
	call_deferred("set_monitoring", false) #Using call_deferred() allows us to have Godot wait to disable the shape until it’s safe to do so.

func start(pos):
	position = pos
	show()
	monitoring = true