extends Node

func _on_AnimationPlayer_animation_finished(anim_name):
	$Music.play()
	$AnimationPlayer.play("second")

func _on_Button_pressed():
	$Pressed.play()
	$Slider.play("right")