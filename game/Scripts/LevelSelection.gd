extends Node

var textures = ["res://Assets/Art/UI/platforms/pixel_small_platform.png",
				"res://Assets/Art/UI/platforms/pixel_platform.png",
				"res://Assets/Art/UI/platforms/pixel_big_platform.png"]
onready var columns = $UI/Rows/Second/Platforms
onready var page = $UI/Rows/First/Labels/Page
var cur_area = "ZA"
var number = 0
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
	# get the texture buttons
	for node in columns.get_children():
		if not "Btn" in node.name:
			buttons.append(node)

	fill_row()
	# update max page info
	pages = platforms.size() / buttons.size()
	if platforms.size() % buttons.size() > 0:
		pages += 1
	page.text = "1/%s" % str(pages)

func fill_row():
	var sizes = []
	# find 5 platforms in the json
	for p in range(number, number + buttons.size()):
		var i = p % buttons.size()
		if p < platforms.size():
			buttons[i].modulate.a = 1
			var id = int(platforms[p]["ccodice"])
			var size = DataHandler.get_value(id, "cdimensioni")
			size = DataHandler.format_dimensions(size)
			sizes.append(size)
			# update the buttons
			if sizes[i] < 1000:
				buttons[i].texture_normal = load(textures[0])
			elif sizes[i] >= 1000 and sizes[i] < 1500:
				buttons[i].texture_normal = load(textures[1])
			else:
				buttons[i].texture_normal = load(textures[2])
		else:
			buttons[i].modulate.a = 0
	print(sizes)
	# show info for the seleced button


func _on_BtnRight_pressed():
	# update the buttons
	number += buttons.size()
	fill_row()
	# update page
	cur_page += 1
	page.text = "%s/%s" % [str(cur_page), str(pages)]
	# enable left button
	if $UI/Rows/Second/Platforms/BtnLeft.disabled:
		$UI/Rows/Second/Platforms/BtnLeft.disabled = false
	# disable if last page
	if cur_page == pages:
		$UI/Rows/Second/Platforms/BtnRight.disabled = true

func _on_BtnLeft_pressed():
	# update the buttons
	number -= buttons.size()
	fill_row()
	# update page
	cur_page -= 1
	page.text = "%s/%s" % [str(cur_page), str(pages)]
	# enable right button
	if $UI/Rows/Second/Platforms/BtnRight.disabled:
		$UI/Rows/Second/Platforms/BtnRight.disabled = false
	# disable if first page
	if cur_page == 1:
		$UI/Rows/Second/Platforms/BtnLeft.disabled = true





