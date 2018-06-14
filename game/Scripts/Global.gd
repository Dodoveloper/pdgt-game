extends Node

var money = 1000
var platform_info # dictionary generated in the platform scene

func decrease_money(value):
	if money - value >= 0:
		money -= value
		return true
	else:
		print("Insufficient money!")
		return false