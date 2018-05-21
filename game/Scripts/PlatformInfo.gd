extends NinePatchRect

onready var infos = get_parent().info_dict

func _ready():
	pass # replace with function body

func _on_PlatformInfo_draw():
	# display the text
	for row in $Rows.get_children():
		row.get_node("HBox/Label").text = row.name + ":"
		row.get_node("HBox/Value").text = String(infos[row.name])
