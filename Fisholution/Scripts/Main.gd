extends Node

export (Array, PackedScene) var BadFishes

onready var fish = $Fish
onready var fish_bfp_bfsl = $Fish/BadFishPath/BFSpawnLocation
onready var start_position = $StartPosition
onready var hud = $HUD
onready var hud_fb = $HUD/FisholutionBar
onready var hud_sl = $HUD/ScoreLabel
onready var hud_hsl = $HUD/HighscoreLabel
onready var start_timer = $StartTimer
onready var score_timer =$ScoreTimer
onready var badfish_timer = $BadFishTimer
onready var gameover_sound = $GameOverSound
onready var music = $Music

var score

func _ready():
	randomize()

func new_game():
	score = 0
	fish.start(start_position.position)
	fish.scale = Vector2(2, 2)
	start_timer.start()
	hud.show_message("Get Ready")
	hud.update_score(score)
	hud_fb.show()
	music.play()
	hud_fb.reset_fisholution()

func game_over():
	score_timer.stop()
	badfish_timer.stop()
	hud.game_over()
	gameover_sound.play()
	music.stop()
	$"/root/PlayerData".save_highscore(score) #save highscore

func _on_StartTimer_timeout():
	badfish_timer.start()
	score_timer.start()
	hud.update_score(score)

func _on_ScoreTimer_timeout():
	score += 1
	hud_sl.text = str(score) #score problem fixed with this line

func _on_BadFishTimer_timeout():
	# Choose a random location on Path2D.
    fish_bfp_bfsl.set_offset(randi())
    # Create a BadFish instance and add it to the scene.
    var badfish = BadFishes[randi() % BadFishes.size()].instance()
    add_child(badfish)
    # Set the badfish's direction perpendicular to the path direction.
    var direction = fish_bfp_bfsl.rotation + PI / 2
    # Set the badfish's position to a random location.
    badfish.position = fish_bfp_bfsl.global_position
    # Add some randomness to the direction.
    direction += rand_range(-PI / 4, PI / 4) # PI/4 means 45 angle
    badfish.rotation = direction
    # Set the velocity (speed & direction).
    badfish.linear_velocity = Vector2(rand_range(badfish.min_speed, badfish.max_speed), 0)
    badfish.linear_velocity = badfish.linear_velocity.rotated(direction)
    # [DemoFish]Set the velocity (speed & direction).
#    var badfishRB = badfish.find_node("RigidBody2D")
#    badfishRB.linear_velocity = Vector2(rand_range(badfish.min_speed, badfish.max_speed), 0)
#    badfishRB.linear_velocity = badfishRB.linear_velocity.rotated(direction)