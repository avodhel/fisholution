extends Area2D

signal hit #when something hits our fish
signal xp_gained # when fish eat little fish

export (int) var speed = 200
var velocity = Vector2()
var screensize
#var fish_scale

func _ready():
	hide() # invisible fish when the game first start
	screensize = get_viewport_rect().size
#	fish_scale = $Sprite.scale

func _process(delta):
	velocity = Vector2()

	if Input.is_action_pressed("ui_right"):
        velocity.x += 1
        $Sprite/AnimationPlayer.play("right")
	if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
        $Sprite/AnimationPlayer.play("left")
	if Input.is_action_pressed("ui_down"):
        velocity.y += 1
        $Sprite/AnimationPlayer.play("down")
	if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
        $Sprite/AnimationPlayer.play("up")

	if velocity.length() > 0:
        $Bubble.emitting = true
        velocity = velocity.normalized() * speed
	else:
        $Bubble.emitting = false
        
	position += velocity * delta
#	position.x = clamp(position.x, 0, screensize.x)
#	position.y = clamp(position.y, 0, screensize.y)

func _on_Fish_body_entered(body): #when something hit fish's collision this func works
#	print(body.collider.name)

	if body.sprite_scale > scale: #if badfish is bigger than our fish
		hide()
		emit_signal("hit") #game will know fish died
		call_deferred("set_monitoring", false) #Using call_deferred() allows us to have Godot wait to disable the shape until it’s safe to do so.
	else:
		body.hide()
		emit_signal("xp_gained")

func start(pos):
	position = pos
	show()
	monitoring = true

func _on_HUD_fisholution_up(): # when fisholution level increase
	scale += Vector2(0.5, 0.5)
