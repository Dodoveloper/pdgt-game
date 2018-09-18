extends Node

var my_token = ""

var money = 500
var platform_id = 220
var platform_info # dictionary generated in the platform scene
var platform_life = 500
var pits_cost = 1000
var gas_percentage = 0
var gas_increase = 0.0
# final values
var initial_life = 0
var victory_bonus = 10000

var is_displaying = false # turretpopup flag

func _ready():
	OS.window_maximized = true

func decrease_money(value):
	if money - value >= 0:
		money -= value
		return true
	else:
		print("Insufficient money!")
		return false