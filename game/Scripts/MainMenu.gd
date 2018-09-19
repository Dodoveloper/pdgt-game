extends Node

func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play("second")

func _on_Button_pressed():
	$Slider.play("right")
