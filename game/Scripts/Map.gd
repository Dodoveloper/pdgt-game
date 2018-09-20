extends Node

export (int) var enemy_count

var spawn_rate = 0
var prev_percentage = 0 # gas
var Enemy = preload("res://Scenes/Enemy.tscn")
onready var level

func _ready():
	randomize()
	level = get_children()[get_child_count() - 1]
	$Platform.position = $TestScene/FinalPos.position
	spawn_rate = $SpawnRate.wait_time
	prev_percentage = Global.gas_percentage

func _on_SpawnRate_timeout():
	if enemy_count > 0:
		var is_swordfish = false
		# choose randomly enemy type
		is_swordfish = select_random_enemy()
		# instance the enemy
		var e = Enemy.instance()
		e.is_swordfish = is_swordfish
		add_child(e)
		# set its position
		e.global_position = level.get_node("StartPos").position
		# initialize its variables
		e.goal = level.get_node("FinalPos").position
		e.nav = level.get_node("Navigation2D")
		# decrease counter
		enemy_count -= 1
		# check the gas percentage
		if Global.gas_percentage >= prev_percentage + 10:
			if spawn_rate > 0.5:
				spawn_rate -= 0.5
				prev_percentage = Global.gas_percentage
		# randomize the timer
		$SpawnRate.wait_time = rand_range(spawn_rate - 0.5, spawn_rate)

func select_random_enemy():
	var outcome = {
		false : 80,
		true : 20
	}
	var tot_weight = 100
	var rand = randi() % tot_weight
	var output = null

	for key in outcome.keys():
		if rand < outcome[key]:
			output = key
			break
		rand -= outcome[key]

	return output

func _on_HUD_weather_acquired(weather):
	if weather == "Clouds":
		$TileMap.modulate = Color("8ed3a7")
	elif weather == "Rain" or weather == "Snow":
		$TileMap.modulate = Color("8ed3a7")
		# particles
		$Camera2D/WeatherEffects/Rain.emitting = true
	else:
		$Camera2D/WeatherEffects/Rain.emitting = false
		$TileMap.modulate = Color(1.0, 1.0, 1.0, 1.0)






