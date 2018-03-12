extends Node2D

onready var screensize = get_viewport_rect().size
onready var cell_size = 64
onready var grid_size = Vector2(int(screensize.x / cell_size), int(ceil(screensize.y / cell_size)))
onready var tile_size = Vector2(cell_size, cell_size)

func _ready():
	print(grid_size)

func _draw():
	var LINE_COLOR = Color(1, 1, 1)
	var LINE_WIDTH = 2

	for x in range(0, grid_size.x + 1):
		var next_pos = x * tile_size.x
		var limit = grid_size.y * tile_size.y
		draw_line(Vector2(next_pos, 0), Vector2(next_pos, limit), LINE_COLOR, LINE_WIDTH)

	for y in range(0, grid_size.y + 1):
		var next_pos = y * tile_size.y
		var limit = grid_size.x * tile_size.x
		draw_line(Vector2(0, next_pos), Vector2(limit, next_pos), LINE_COLOR, LINE_WIDTH)