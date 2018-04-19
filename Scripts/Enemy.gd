extends KinematicBody2D

var speed = 600
var nav = null setget set_nav
var path = []
var goal = Vector2()
var life = 30

func set_nav(new_nav):
	nav = new_nav
	path = nav.get_simple_path(global_position, goal, false)

func _physics_process(delta):
	# travel to the next point
	if path.size() > 1:
		var d = global_position.distance_to(path[0])
		if d > 6:
			global_position = global_position.linear_interpolate(path[0], 
					(speed * delta) / d)
		else:
			path.remove(0)
	else:
		queue_free()

func hit(damage):
	# check remaining life
	if life > damage:
		life -= damage
	else:
		queue_free()

func _on_Scan_area_entered( area ):
	print("%s entered" %area.name)
