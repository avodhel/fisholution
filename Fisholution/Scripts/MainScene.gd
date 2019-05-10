extends CanvasLayer

func _on_StartButton_pressed():
	$"/root/SceneManager".change_scene("ChooseScreen") # open fish choose screen
