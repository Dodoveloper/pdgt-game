extends CanvasLayer

signal turret_requested

onready var small = $PanelContainer/Turrets/Small
onready var medium = $PanelContainer/Turrets/Medium
onready var big = $PanelContainer/Turrets/Big
var small_price = "100"
var medium_price = "400"
var big_price = "1000"

func _on_small_pressed():
	# enable the price button
	small.get_node("Price").disabled = false
	# display the buy button if pressed
	if small.get_node("Type").pressed:
		small.get_node("Price").text = "Click to buy (%s)" % small_price
	# check if other buttons are pressed and unpress them
	if medium.get_node("Type").pressed:
		medium.get_node("Type").pressed = false
		medium.get_node("Type").emit_signal("pressed")
	if big.get_node("Type").pressed:
		big.get_node("Type").pressed = false
		big.get_node("Type").emit_signal("pressed")
	# reset the message if unpressed
	if not small.get_node("Type").pressed:
		small.get_node("Price").text = small_price
		small.get_node("Price").disabled = true

func _on_medium_pressed():
	# enable the price button
	medium.get_node("Price").disabled = false
	# display the buy button if pressed
	if medium.get_node("Type").pressed:
		medium.get_node("Price").text = "Click to buy (%s)" % medium_price
	if small.get_node("Type").pressed:
		small.get_node("Type").pressed = false
		small.get_node("Type").emit_signal("pressed")
	if big.get_node("Type").pressed:
		big.get_node("Type").pressed = false
		big.get_node("Type").emit_signal("pressed")
	# clear the message
	if not medium.get_node("Type").pressed:
		medium.get_node("Price").text = medium_price
		medium.get_node("Price").disabled = true

func _on_big_pressed():
	# enable the price button
	big.get_node("Price").disabled = false
	# display the buy button if pressed
	if big.get_node("Type").pressed:
		big.get_node("Price").text = "Click to buy (%s)" % big_price
	if small.get_node("Type").pressed:
		small.get_node("Type").pressed = false
		small.get_node("Type").emit_signal("pressed")
	if medium.get_node("Type").pressed:
		medium.get_node("Type").pressed = false
		medium.get_node("Type").emit_signal("pressed")
	# clear the message
	if not big.get_node("Type").pressed:
		big.get_node("Price").text = big_price
		big.get_node("Price").disabled = true

func _on_Small_Price_pressed():
	if Global.decrease_money(int(small_price)):
		emit_signal("turret_requested", "Small")
	else:
		$Error.play()

func _on_Medium_Price_pressed():
	if Global.decrease_money(int(medium_price)):
		emit_signal("turret_requested", "Medium")
	else:
		$Error.play()

func _on_Big_Price_pressed():
	if Global.decrease_money(int(big_price)):
		emit_signal("turret_requested", "Big")
	else:
		$Error.play()

func _on_CloseButton_pressed():
	# close this instance
	Global.is_displaying = false
	self.queue_free()
