extends Camera2D

var first_touch = false
var previous_touch = Vector2()
var zoom_factor = 1.1
var zoom_speed = 10
var zoom_pos = Vector2()
var zoom_weight = 0.7
const MAX_ZOOM = 0.6
const MIN_ZOOM = 1.8

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
			# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_pos = get_global_mouse_position()
				zoom_at(zoom_pos, 1 / zoom_factor)
			# zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom_pos = get_global_mouse_position()
				zoom_at(zoom_pos, zoom_factor)

func zoom_at(pos, step):
	zoom.x = lerp(zoom.x, zoom.x * step, zoom_weight)
	zoom.y = lerp(zoom.y, zoom.y * step, zoom_weight)
	zoom.x = clamp(zoom.x, MAX_ZOOM, MIN_ZOOM)
	zoom.y = clamp(zoom.y, MAX_ZOOM, MIN_ZOOM)
	position.x = lerp(position.x, pos.x, 0.2)
	position.y = lerp(position.y, pos.y, 0.2)


