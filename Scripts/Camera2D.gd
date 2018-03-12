extends Camera2D

var first_touch = false
var previous_touch = Vector2()

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		if not first_touch:
			previous_touch = event.relative
			first_touch = true
		else:
			var result = (event.relative * 3) - previous_touch
			global_position -= result
			first_touch = false

