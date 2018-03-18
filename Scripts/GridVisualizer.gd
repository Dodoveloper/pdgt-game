extends TileMap

onready var screensize = get_viewport_rect().size
onready var grid_size = Vector2(36, 21) # number of cells

func _ready():
	z_index = 10 # testing

func _draw():
	var LINE_COLOR = Color(1, 1, 1, 0.2)
	var LINE_WIDTH = 2

	# draw the columns
	for x in range(-grid_size.x, grid_size.x + 1):
		var next_pos = x * cell_size.x
		var start_y = (-grid_size.y * cell_size.y) - 1
		var limit = grid_size.y * cell_size.y
		draw_line(Vector2(next_pos, start_y), Vector2(next_pos, limit), LINE_COLOR, LINE_WIDTH)
	# draw the rows
	for y in range(-grid_size.y, grid_size.y + 1):
		var next_pos = y * cell_size.y
		var start_x = -grid_size.x * cell_size.x
		var limit = grid_size.x * cell_size.x
		draw_line(Vector2(start_x, next_pos), Vector2(limit, next_pos), LINE_COLOR, LINE_WIDTH)