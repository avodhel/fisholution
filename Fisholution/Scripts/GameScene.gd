extends Node

export (Array, PackedScene) var enemy_fishes
export (Array, PackedScene) var enemy_not_fishes

onready var fish_pos = $Fish_Pos
onready var enemy_spawn_location = $Fish_Pos/EnemyPath/EnemySpawnLocation
onready var hud = $HUD
onready var hud_fb = $HUD/FisholutionBar
onready var hud_sl = $HUD/Labels/ScoreLabel
#onready var hud_hsl = $HUD/HighscoreLabel
onready var hud_ft = $HUD/FishTable
onready var hud_st = $HUD/ScoreTable
onready var start_timer = $StartTimer
onready var score_timer =$ScoreTimer
onready var enemy_timer = $EnemyTimer
onready var gameover_sound = $GameOverSound

var Enemies = []
var score
#var rand_scale
var fish_scene
var fish_instance
var instance_unique_fish

func _ready():
	Enemies = enemy_fishes + enemy_not_fishes
	_prepare_game()
	_prepare_hud()
	_prepare_fish()

func _prepare_fish():
	if Global.which_mode == "fisholution":
		_unique_fish()
	elif Global.which_mode == "natural_selection":
		_chosen_fish(Global.fish_no)
		hud_fb.hide()

func _prepare_game():
	if fish_instance != null:
		fish_instance.respawn(true)
		fish_instance.stop(false)
	score = 0
	start_timer.start()

func _prepare_hud():
	hud.show_message("Get Ready", true)
	hud.update_score(score)
	hud.score_label.visible = true
	hud_fb.show()
	hud_fb.reset_fisholution()
	if Global.which_mode == "natural_selection":
		#instance tables
		var tables = ResourceLoader.load("res://Scenes/UI/Tables.tscn")
		var instance_tables = tables.instance()
		hud.add_child(instance_tables)
		hud_ft = instance_tables.get_node("FishTable")
		hud_st = instance_tables.get_node("ScoreTable")
		hud_ft.reset_table()
		hud_ft.table_transparency(true)
		hud_ft.connect("eliminate_fish", self, "_eliminate_fish")
		hud_st.connect("ns_completed", hud, "_show_ns_completed_panel")
		hud_st.reset_table()
		hud_st.table_transparency(true)

func _unique_fish(): #prepare fish for fisholution mode
	var unique_fish = ResourceLoader.load("res://Scenes/Fish.tscn")
	instance_unique_fish = unique_fish.instance()
	add_child(instance_unique_fish)
	instance_unique_fish.position = fish_pos.position
	#node position
	self.add_child_below_node(fish_pos, instance_unique_fish)
	#reparenting
	var fish_cam = get_node("Fish_Pos/FishCam")
	var water_effect = get_node("Fish_Pos/WaterEffect")
	var enemy_path = get_node("Fish_Pos/EnemyPath")
	fish_pos.remove_child(fish_cam)
	fish_pos.remove_child(water_effect)
	fish_pos.remove_child(enemy_path)
	instance_unique_fish.add_child(fish_cam)
	instance_unique_fish.add_child(water_effect)
	instance_unique_fish.add_child(enemy_path)
	#signals
	instance_unique_fish.connect("hit", self, "game_over")
	instance_unique_fish.connect("xp_gained", hud, "_on_Fish_xp_gained")
	hud.connect("fisholution_up", instance_unique_fish, "_on_HUD_fisholution_up")

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

func _load_fish(path, fish_name): #preapare fish for natural_selection mod
	fish_scene = load(path)
	fish_instance = fish_scene.instance()
	fish_instance.set_name(fish_name)
	fish_instance.set_script(preload("res://Scripts/FishControl.gd"))
	add_child(fish_instance)
	fish_instance.position = fish_pos.position
	hud_ft.increase_or_reduce(fish_instance, "inc", "fishtable")
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
	fish_instance.connect("my_fish_eaten", self, "_on_fish_eaten")
	#die_effect(tween)
	var die_effect = Tween.new()
	fish_instance.add_child(die_effect)
	die_effect.playback_speed = 0.2
	fish_instance.die_effect = fish_instance.get_node("die_effect")
	Global.die_effect(fish_instance.die_effect, fish_instance)
	die_effect.connect("tween_completed", fish_instance, "_on_die_effect_tween_completed")

func game_over():
	score_timer.stop()
	enemy_timer.stop()
	hud.game_over()
	gameover_sound.play()
	Global.save_highscore(score) #save highscore
	if Global.which_mode == "natural_selection":
		hud_ft.table_transparency(false)
		hud_st.table_transparency(false)
		fish_instance.stop(true)
		hud_ft.increase_or_reduce(fish_instance, "red", "fishtable")
	elif Global.which_mode == "fisholution":
		instance_unique_fish.stop(true)

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
	if !enemy.is_in_group("not_fish") and Global.which_mode == "natural_selection":
		hud_ft.increase_or_reduce(enemy, "inc", "fishtable")
		#make contact with "fish_died" signal
		enemy.connect("fish_died", self, "_on_fish_died")
		enemy.connect("fish_eaten", self, "_on_fish_eaten")

func _on_fish_died(which_fish):
	hud_ft.increase_or_reduce(which_fish, "red", "fishtable")

func _on_fish_eaten(by_who):
	hud_st.increase_or_reduce(by_who, "inc", "scoretable")

func _eliminate_fish(fish_no):
#	print(enemy_fishes.size())
	for f in enemy_fishes.size():
		if enemy_fishes[f]._bundled.names[0] == "BadFish" + str(fish_no + 1):
#			print(enemy_fishes[f]._bundled.names[0])
			enemy_fishes.remove(f)
			Enemies = enemy_fishes + enemy_not_fishes
			break


