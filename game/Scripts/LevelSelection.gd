extends Node

var textures = ["res://Assets/Art/UI/platforms/pixel_small_platform.png",
				"res://Assets/Art/UI/platforms/pixel_platform.png",
				"res://Assets/Art/UI/platforms/pixel_big_platform.png"]
onready var columns = $UI/Rows/Second/Platforms
onready var page = $UI/Rows/First/Labels/Page
var number = 0
var cur_area = "ZA"
var platforms = []
var buttons = []
var cur_page = 1
var pages = 0

func _ready():
	# find all platforms within the current area
	for p in DataHandler.data.size():
		var id = int(DataHandler.data[p]["ccodice"])
		var area = DataHandler.get_value(id, "czona")
		area = DataHandler.format_string(area)
		if area == cur_area:
			platforms.append(DataHandler.data[p])
	fill_row()
	# update max page info
	pages = platforms.size() / buttons.size()
	if platforms.size() % buttons.size() > 0:
		pages += 1
	page.text = "1/%s" % str(pages)

func fill_row():
	var sizes = []
	# get the texture buttons
	for node in columns.get_children():
		if not "Btn" in node.name:
			buttons.append(node)
	# find 5 platforms in the json
	for p in platforms.size():
		# stop every 5 platforms
		if p == number + buttons.size():
			break
		var id = int(DataHandler.data[p]["ccodice"])
		var size = DataHandler.get_value(id, "cdimensioni")
		size = DataHandler.format_dimensions(size)
		sizes.append(size)
	# update the buttons
	for b in buttons.size():
		if b == platforms.size():
			buttons[b].modulate.a = 0
		else:
			if sizes[b] < 1000:
				buttons[b].texture_normal = load(textures[0])
			elif sizes[b] >= 1000 and sizes[b] < 1500:
				buttons[b].texture_normal = load(textures[1])
			else:
				buttons[b].texture_normal = load(textures[2])
	# show info for the seleced button


func _on_BtnRight_pressed():
	# update the buttons
	number += buttons.size()
	fill_row()
	# update page
	cur_page += 1
	page.text = "%s/%s" % [str(cur_page), str(pages)]
	






