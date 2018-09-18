extends Node

var victory = false
onready var score = Global.money
var win_bonus = 0
var life_bonus = 0
var life_percentage = 0
var total = 0

func _ready():
	get_tree().paused = true
	if victory:
		$VBoxContainer/Outcome.text = "vittoria!"
		win_bonus = Global.victory_bonus
		life_percentage = (Global.platform_life * 100) / Global.initial_life
		life_bonus = (life_percentage / 100) * Global.victory_bonus
		print(life_bonus)
	else:
		$VBoxContainer/Outcome.text = "sconfitta!"
	# compute score
	total = score + win_bonus + life_bonus
	# display score
	$VBoxContainer/ScoreMargin/Score/Money/Label2.text = str(score)
	$VBoxContainer/ScoreMargin/Score/WinBonus/Label4.text = str(win_bonus)
	$VBoxContainer/ScoreMargin/Score/LifeBonus/Label6.text = str(life_bonus)
	$VBoxContainer/ScoreMargin/Score/Total/Label8.text = str(total)

func _on_Menu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _on_Level_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/LevelSelection.tscn")

