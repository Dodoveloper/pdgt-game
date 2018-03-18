extends Sprite

var speed = 100
onready var nav = get_parent().get_node("Navigation2D")
var path = []
var goal = Vector2()

func _ready():
	global_position = get_parent().get_node("StartPos").position
	path = get_parent().get_node("Navigation2D").get_simple_path(global_position,
			get_parent().get_node("FinalPos").position, false)
	print(path)

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
