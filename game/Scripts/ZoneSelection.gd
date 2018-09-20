extends MarginContainer

onready var buttons = $VBoxContainer/Columns/Right.get_children()
onready var zones = $VBoxContainer/Columns/Left.get_children()

var LevelSelection = preload("res://Scenes/LevelSelection.tscn")

func _ready():
	zones.remove(0)

func highlight_zone(name):
	# play the sound
	$PressedSound.play()
	# highlight the button
	for btn in buttons:
		if btn.name == name:
			btn.modulate.a = 1.0
		else:
			btn.modulate.a = 0.5
	# highlight the zone in the map
	for zone in zones:
		if zone.name == name:
			zone.modulate.a = 1.0
		else:
			zone.modulate.a = 0.5

	$VBoxContainer/Columns/Confirm.disabled = false
	# set the current zone
	Global.cur_zone = name

func _on_ZA_pressed():
	highlight_zone("ZA")

func _on_ZB_pressed():
	highlight_zone("ZB")

func _on_ZC_pressed():
	highlight_zone("ZC")

func _on_ZD_pressed():
	highlight_zone("ZD")

func _on_Confirm_pressed():
	$ConfirmSound.play()

func _on_ConfirmSound_finished():
	if get_parent().name == "MainMenu":
		var ls = LevelSelection.instance()
		get_parent().add_child(ls)
		queue_free()

func _on_Back_pressed():
	$BackSound.play()
	if get_parent().name == "MainMenu":
		get_parent().get_node("Slider").play_backwards("right")





