extends Control

onready var game_music = $Music/game_music
onready var sounds = $Sounds
onready var bubble_sound = $Sounds/bubble_sound
onready var nom_sound = $Sounds/nom_sound
onready var gameover_sound = $Sounds/gameover_sound
onready var sea_sound = $Sounds/sea_sound
onready var water_click_sound = $Sounds/water_click_sound

var sounds_elements = []

#temporary variables
const SAVE_PATH = "user://settings.save"
var settings = {}

#saved variables
var music_volume = 2000
var sounds_volume = 2000

func _ready():
#	reset_settings()
	load_settings()
	sounds_elements = sounds.get_children()

func _process(delta):
	game_music.set_max_distance(music_volume)
	for s in sounds_elements.size():
		sounds_elements[s].set_max_distance(sounds_volume)

func save_settings():
	var settings = {
	music_volume = music_volume,
	sounds_volume = sounds_volume
	}
	
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	save_file.store_line(to_json(settings))
	save_file.close()

func load_settings():
	var save_file = File.new()
	if !save_file.file_exists(SAVE_PATH):
		return

	save_file.open(SAVE_PATH, File.READ)
	var data = {}
	data = parse_json(save_file.get_as_text())
	
	music_volume = data["music_volume"]
	sounds_volume = data["sounds_volume"]

func reset_settings():
	var dir = Directory.new()
	dir.remove(SAVE_PATH)



