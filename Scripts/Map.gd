extends Node2D

export (int) var enemy_count
var spawn_rate

var Enemy = preload("res://Scenes/Enemy.tscn")

func _ready():
	randomize()

func _on_SpawnRate_timeout():
	if enemy_count > 0:
		# instance the enemy
		var e = Enemy.instance()
		add_child(e)
		# set its position
		e.global_position = $TestScene/StartPos.position
		# initialize its variables
		e.goal = $TestScene/FinalPos.position
		e.nav = $TestScene/Navigation2D
		# decrease counter
		enemy_count -= 1
		# randomize the timer
		$SpawnRate.wait_time = rand_range(0.5, 2)
