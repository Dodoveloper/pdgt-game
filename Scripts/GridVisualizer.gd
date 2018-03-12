extends Node2D

func _ready():
	pass

func _draw():
	var LINE_COLOR = Color(1, 1, 1)
	var LINE_WIDTH = 2
	var screensize = get_viewport_rect().size
	
	print(screensize)
	for x in range(0, screensize.x):
		draw_line(Vector2(x, 0), Vector2(x, screensize.x), LINE_COLOR)
		x += 32