extends Node

var money = 1000

func decrease_money(value):
	if money - value >= 0:
		money -= value
		return true
	else:
		print("Insufficient money!")
		return false