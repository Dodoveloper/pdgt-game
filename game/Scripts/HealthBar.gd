extends Node2D

var green_texture = preload("res://Assets/Art/UI/green_button00.png")
var yellow_texture = preload("res://Assets/Art/UI/yellow_button00.png")
var red_texture = preload("res://Assets/Art/UI/red_button00.png")

func _process(delta):
	$Progress.value = Global.platform_life

func _on_TextureProgress_value_changed(value):
	if value <= $Progress.max_value / 2:
		$Progress.texture_progress = yellow_texture
	if value <= $Progress.max_value / 4:
		$Progress.texture_progress = red_texture
