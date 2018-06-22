extends Node

var money = 500
var platform_info # dictionary generated in the platform scene
var platform_life
var pits_cost = 1000

func decrease_money(value):
	if money - value >= 0:
		money -= value
		return true
	else:
		print("Insufficient money!")
		return false