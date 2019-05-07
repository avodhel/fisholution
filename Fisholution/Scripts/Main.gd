extends Node

export (Array, PackedScene) var enemy_fishes
export (Array, PackedScene) var enemy_not_fishes

onready var fish = $Fish
onready var enemy_spawn_location = $Fish/EnemyPath/EnemySpawnLocation
onready var start_position = $StartPosition
onready var hud = $HUD
onready var hud_fb = $HUD/FisholutionBar
onready var hud_sl = $HUD/ScoreLabel
onready var hud_hsl = $HUD/HighscoreLabel
onready var hud_ft = $HUD/FishTable
onready var start_timer = $StartTimer
onready var score_timer =$ScoreTimer
onready var enemy_timer = $EnemyTimer
onready var gameover_sound = $GameOverSound
onready var music = $Music

var Enemies = []
var score
var rand_scale

func _ready():
	Enemies = enemy_fishes + enemy_not_fishes
	randomize()

func new_game():
	score = 0
	fish.start(start_position.position)
	rand_scale = rand_range(1.5, 2)
	fish.scale = Vector2(rand_scale, rand_scale) #randomness for our fish's scale
	fish.stop(false) # move fish
	start_timer.start()
	hud.show_message("Get Ready")
	hud.update_score(score)
	hud_fb.show()
	hud_fb.reset_fisholution()
	music.play()

func game_over():
	score_timer.stop()
	enemy_timer.stop()
	hud.game_over()
	gameover_sound.play()
	music.stop()
	$"/root/PlayerData".save_highscore(score) #save highscore
	fish.stop(true) # stop fish

func _on_StartTimer_timeout():
	enemy_timer.start()
	score_timer.start()
	hud.update_score(score)

func _on_ScoreTimer_timeout():
	score += 1
	hud_sl.text = str(score) #score problem fixed with this line

func _on_EnemyTimer_timeout():
    # Choose a random location on Path2D.
	enemy_spawn_location.set_offset(randi())
    # Create a enemy instance and add it to the scene.
	var enemy = Enemies[randi() % Enemies.size()].instance()
	add_child(enemy)
#	if enemy.is_in_group("not_fish"):
#		if rand_range(0, 100) > 65:
#			add_child(enemy)
#		else:
#			return
#	else:
#		add_child(enemy)
	hud_ft.increase_or_reduce(enemy, "inc")
    # Set the enemy's direction perpendicular to the path direction.
	var direction = enemy_spawn_location.rotation + PI / 2
    # Set the enemy's position to a random location.
	enemy.position = enemy_spawn_location.global_position
    # Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4) # PI/4 means 45 angle
	enemy.rotation = direction
    # Set the velocity (speed & direction).
	enemy.linear_velocity = Vector2(rand_range(enemy.min_speed, enemy.max_speed), 0)
	enemy.linear_velocity = enemy.linear_velocity.rotated(direction)