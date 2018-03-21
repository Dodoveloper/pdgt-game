extends Camera2D

var first_touch = false
var previous_touch = Vector2()
var zoom_factor = 1.0
var zoom_speed = 10
var zoom_pos = Vector2()
var zoom_margin = 0.1
var zooming = false

func _unhandled_input(event):
	# camera drag
	if event is InputEventScreenDrag:
		if not first_touch:
			previous_touch = event.relative
			first_touch = true
		else:
			var result = (event.relative * 3) - previous_touch
			global_position -= result
			first_touch = false
	# zoom
	if event is InputEventMouseButton:
		if event.is_pressed():
			zooming = true
			# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_factor -= 0.01
				zoom_pos = get_global_mouse_position()
			# zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom_factor += 0.01
				zoom_pos = get_global_mouse_position()
	# stop the zooming if moving the mouse
	if abs(zoom_pos.x - get_global_mouse_position().x) > zoom_margin:
		zoom_factor = 1.0
	if abs(zoom_pos.y - get_global_mouse_position().y) > zoom_margin:
		zoom_factor = 1.0

func _process(delta):
	zoom.x = lerp(zoom.x, zoom.x * zoom_factor, zoom_speed * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoom_factor, zoom_speed * delta)
	zoom.x = clamp(zoom.x, 0.5, 2.0)
	zoom.y = clamp(zoom.y, 0.5, 2.0)

