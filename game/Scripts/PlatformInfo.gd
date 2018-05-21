extends NinePatchRect

onready var infos = get_parent().info_dict
var max_row = 0

func _on_PlatformInfo_draw():
	# display the text
	for row in $Rows.get_children():
		row.get_node("HBox/Label").text = row.name + ":"
		row.get_node("HBox/Value").text = String(infos[row.name])
		if row.rect_size.x > max_row:
			max_row = row.rect_size.x + 100

func _process(delta):
	# update accordingly to children's size
	rect_size.x = max_row