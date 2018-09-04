extends Node

export (int) var enemy_count

var spawn_rate = 0
var Enemy = preload("res://Scenes/Enemy.tscn")
onready var level

func _ready():
	randomize()
	level = get_children()[get_child_count() - 1]
	$Platform.position = $TestScene/FinalPos.position
	spawn_rate = $SpawnRate.wait_time

func _on_SpawnRate_timeout():
	if enemy_count > 0:
		# instance the enemy
		var e = Enemy.instance()
		add_child(e)
		# set its position
		e.global_position = level.get_node("StartPos").position
		# initialize its variables
		e.goal = level.get_node("FinalPos").position
		e.nav = level.get_node("Navigation2D")
		# decrease counter
		enemy_count -= 1
		# randomize the timer
		$SpawnRate.wait_time = rand_range(spawn_rate - 1.5, spawn_rate)
		if spawn_rate >= 2.0:
			spawn_rate -= 0.2
