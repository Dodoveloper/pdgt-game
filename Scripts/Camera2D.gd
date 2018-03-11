extends Camera2D

func _ready():
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var mouse_pos = event.global_position
		position = mouse_pos

#func _process(delta):
#	if Input.is_action_pressed("click"):
#		var mouse_pos = get_global_mouse_position()
#		position = mouse_pos