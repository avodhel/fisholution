extends Control

onready var game_music = $Music/game_music
onready var bubble_sound = $Sounds/bubble_sound
onready var nom_sound = $Sounds/nom_sound
onready var gameover_sound = $Sounds/gameover_sound

#temporary variables
const save_path = "res://save.json"
var settings = {}
var play_music = 1
var play_sounds = 1
var new_choice = 1
var song
var menu = true

#saved variables
var master_volume = 2000
var music_volume = 2000
var sounds_volume = 2000

func _ready():
	choose_music()

func _process(delta):
	if game_music.is_playing():
		choose_music()
	
	if master_volume > 0 and music_volume > 0:
		play_music = int((master_volume / 2000) * (music_volume * 2000) * 2000)
	else:
		play_music = 1

	if master_volume > 0 and sounds_volume > 0:
		play_sounds = int((master_volume / 2000) * (sounds_volume * 2000) * 2000)
	else:
		play_sounds = 1
	
	game_music.set_max_distance(play_music)

func choose_music():
	if menu:
		menu_music()
	else:
		game_music()

func menu_music():
	pass

func game_music():
	pass