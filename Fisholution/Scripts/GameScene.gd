extends Node

export (Array, PackedScene) var enemy_fishes
export (Array, PackedScene) var enemy_not_fishes

onready var fish_pos = $Fish_Pos
#onready var fish = $Fish
onready var enemy_spawn_location = $Fish_Pos/EnemyPath/EnemySpawnLocation
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
var fish_scene
var fish_instance

func _ready():
	Enemies = enemy_fishes + enemy_not_fishes
	_prepare_game()
	_prepare_hud()
	_chosen_fish(Global.fish_no)

func _prepare_game():
	if fish_instance != null:
		fish_instance.respawn(true)
		fish_instance.stop(false)
	score = 0
	start_timer.start()

func _prepare_hud():
	hud.show_message("Get Ready")
	hud.update_score(score)
	hud.score_label.visible = true
	hud_fb.show()
	hud_fb.reset_fisholution()
	hud_ft.reset_table()
	hud_ft.table_transparency(true)

func _chosen_fish(fish_no):
	match fish_no:
		0:
			_load_fish("res://Scenes/enemies/fish/BadFish1.tscn", "fish1")
		1:
			_load_fish("res://Scenes/enemies/fish/BadFish2.tscn", "fish2")
		2:
			_load_fish("res://Scenes/enemies/fish/BadFish3.tscn", "fish3")
		3:
			_load_fish("res://Scenes/enemies/fish/BadFish4.tscn", "fish4")
		4:
			_load_fish("res://Scenes/enemies/fish/BadFish5.tscn", "fish5")
		5:
			_load_fish("res://Scenes/enemies/fish/BadFish6.tscn", "fish6")
		6:
			_load_fish("res://Scenes/enemies/fish/BadFish7.tscn", "fish7")
		7:
			_load_fish("res://Scenes/enemies/fish/BadFish8.tscn", "fish8")
		8:
			_load_fish("res://Scenes/enemies/fish/BadFish9.tscn", "fish9")
		9:
			_load_fish("res://Scenes/enemies/fish/BadFish10.tscn", "fish10")
		10:
			_load_fish("res://Scenes/enemies/fish/BadFish11.tscn", "fish11")
		11:
			_load_fish("res://Scenes/enemies/fish/BadFish12.tscn", "fish12")
		12:
			_load_fish("res://Scenes/enemies/fish/BadFish13.tscn", "fish13")

func _load_fish(path, fish_name):
	fish_scene = load(path)
	fish_instance = fish_scene.instance()
	fish_instance.set_name(fish_name)
	fish_instance.set_script(preload("res://Scripts/FishControl.gd"))
	add_child(fish_instance)
	fish_instance.position = fish_pos.position
	#group
	fish_instance.add_to_group("my_fish")
	fish_instance.add_to_group(fish_name)
	fish_instance.remove_from_group("badfish")
	fish_instance.remove_from_group("enemy")
	#node position
	self.add_child_below_node(fish_pos, fish_instance)
	#reparenting
	var fish_cam = get_node("Fish_Pos/FishCam")
	var water_effect = get_node("Fish_Pos/WaterEffect")
	var enemy_path = get_node("Fish_Pos/EnemyPath")
	fish_pos.remove_child(fish_cam)
	fish_pos.remove_child(water_effect)
	fish_pos.remove_child(enemy_path)
	fish_instance.add_child(fish_cam)
	fish_instance.add_child(water_effect)
	fish_instance.add_child(enemy_path)
	#signals
	fish_instance.disconnect("area_entered", fish_instance, "_on_Enemy_area_entered")
	fish_instance.connect("hit", self, "game_over")

func restart_game():
	Global.change_scene("GameScene") #reload scene
	music.play()

func game_over():
	score_timer.stop()
	enemy_timer.stop()
	hud.game_over()
	hud_ft.table_transparency(false)
	gameover_sound.play()
	music.stop()
	Global.save_highscore(score) #save highscore
	fish_instance.stop(true)

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
#   # Set the enemy's position to a random location.
	enemy.position = enemy_spawn_location.global_position
	# increase fish of number on the fish table
	if !enemy.is_in_group("not_fish"):
		hud_ft.increase_or_reduce(enemy, "inc")
	#make contact with "fish_died" signal
	enemy.connect("fish_died", self, "_on_fish_died")

func _on_fish_died(which_fish):
	hud_ft.increase_or_reduce(which_fish, "red")









