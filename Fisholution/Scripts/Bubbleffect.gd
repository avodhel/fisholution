extends CanvasLayer

onready var animation = $Sprite/AnimationPlayer
onready var sprite = $Sprite

func play_effect():
	animation.play("transition")

func _on_AnimationPlayer_animation_started(anim_name):
	sprite.show()
	Settings.bubble_sound.play()

func _on_AnimationPlayer_animation_finished(anim_name):
	sprite.hide()
