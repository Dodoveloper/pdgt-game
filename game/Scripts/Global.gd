extends Node

var money = 1000 setget decrease_money, get_money

func decrease_money(value):
	if money - value >= 0:
		money -= value
	else:
		print("Insufficient money!")
	print("Money: ", money)

func get_money():
	return money