extends KinematicBody2D

var speed = 150
var nav = null setget set_nav
var path = []
var goal = Vector2()

func set_nav(new_nav):
	nav = new_nav
	path = nav.get_simple_path(global_position, goal, false)

func _physics_process(delta):
	if path.size() > 1:
		var d = global_position.distance_to(path[0])
		if d > 2:
			global_position = global_position.linear_interpolate(path[0], 
					(speed * delta) / d)
		else:
			path.remove(0)
	else:
		queue_free()
