extends Node

var sentences = { 
	true : ["Prossimo passo: la conquista del mondo",
			"Bella vittoria. Peccato non prenda il WiFi"],
	false: ["Dannazione! Ha vinto il bene stavolta",
			"Ti hanno preso a ... pesci in faccia"]
}

var victory = false
onready var score = Global.money
var win_bonus = 0
var life_bonus = 0
var life_percentage = 0
var total = 0

func _ready():
	randomize()
	get_tree().root.get_node("Map/Music").stop()
	get_tree().paused = true
	if victory:
		$VBoxContainer/Outcome.text = "vittoria!"
		win_bonus = Global.victory_bonus
		life_percentage = (Global.platform_life * 100) / Global.initial_life
		life_bonus = (life_percentage * Global.victory_bonus) / 100
	else:
		$LossSound.play()
		$VBoxContainer/Outcome.text = "sconfitta!"
	# generate random sentence
	var rand = randi() % sentences.size()
	$VBoxContainer/Label.text = sentences[victory][rand]
	# compute score
	total = score + win_bonus + life_bonus
	# display score
	$VBoxContainer/ScoreMargin/Score/Money/Label2.text = str(score)
	$VBoxContainer/ScoreMargin/Score/WinBonus/Label4.text = str(win_bonus)
	$VBoxContainer/ScoreMargin/Score/LifeBonus/Label6.text = str(life_bonus)
	$VBoxContainer/ScoreMargin/Score/Total/Label8.text = str(total)

func _on_Menu_pressed():
	restore_values()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _on_Retry_pressed():
	restore_values()
	get_tree().change_scene("res://Scenes/Map.tscn")

func restore_values():
	$PressedSound.play()
	# unpause the game and restore values
	get_tree().paused = false
	Global.money = 500
	Global.gas_percentage = 0
	Global.gas_increase = 0.0



