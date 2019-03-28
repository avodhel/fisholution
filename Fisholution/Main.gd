extends Node

export (PackedScene) var BadFish1
#export (Array, PackedScene) var BadFishes
var score

func _ready():
	randomize()

func new_game():
	score = 0
	$Fish.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Get Ready")
	$HUD.update_score(score)

func game_over():
	$ScoreTimer.stop()
	$BadFishTimer.stop()
	$HUD.game_over()

func _on_StartTimer_timeout():
	$BadFishTimer.start()
	$ScoreTimer.start()
	$HUD.update_score(score)

func _on_ScoreTimer_timeout():
	score += 1
	$HUD/ScoreLabel.text = str(score) #score problem fixed with this line

func _on_BadFishTimer_timeout():
	# Choose a random location on Path2D.
    $BadFishPath/BFSpawnLocation.set_offset(randi())
    # Create a Mob instance and add it to the scene.
    var badfish1 = BadFish1.instance()
    add_child(badfish1)
    # Set the mob's direction perpendicular to the path direction.
    var direction = $BadFishPath/BFSpawnLocation.rotation + PI / 2
    # Set the mob's position to a random location.
    badfish1.position = $BadFishPath/BFSpawnLocation.position
    # Add some randomness to the direction.
    direction += rand_range(-PI / 4, PI / 4) # PI/4 means 45 angle
    badfish1.rotation = direction
    # Set the velocity (speed & direction).
    badfish1.linear_velocity = Vector2(rand_range(badfish1.min_speed, badfish1.max_speed), 0)
    badfish1.linear_velocity = badfish1.linear_velocity.rotated(direction)
