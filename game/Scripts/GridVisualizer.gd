extends TileMap

onready var screensize = Vector2(2560, 1440)
onready var grid_size = screensize / cell_size

func _ready():
	z_index = 10 # testing

#func _draw():
#	var LINE_COLOR = Color(1, 1, 1, 0.2)
#	var LINE_WIDTH = 2
#
#	# draw the columns
#	for x in range(0, ceil(grid_size.x) + 1):
#		var next_pos = x * cell_size.x
#		var limit = ceil(grid_size.y) * cell_size.y
#		draw_line(Vector2(next_pos, 0), Vector2(next_pos, limit), LINE_COLOR, LINE_WIDTH)
#	# draw the rows
#	for y in range(0, ceil(grid_size.y) + 1):
#		var next_pos = y * cell_size.y
#		var limit = grid_size.x * cell_size.x
#		draw_line(Vector2(0, next_pos), Vector2(limit, next_pos), LINE_COLOR, LINE_WIDTH)