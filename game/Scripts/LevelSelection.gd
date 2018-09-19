extends Node

var textures = ["res://Assets/Art/UI/platforms/pixel_small_platform.png",
				"res://Assets/Art/UI/platforms/pixel_platform.png",
				"res://Assets/Art/UI/platforms/pixel_big_platform.png"]
onready var columns = $UI/Rows/Second/Platforms
onready var page = $UI/Rows/First/Labels/Page
onready var platform_infos = $UI/Rows/Third/HBoxContainer/PlatformInfos
onready var play = $UI/Rows/Third/HBoxContainer/Play
onready var map = "res://Scenes/Map.tscn"
var number = 0
var platforms = []
var buttons = []
var cur_page = 1
var pages = 0
var cur_id = 0

func _ready():
	# zone label text
	$UI/Rows/First/Labels/Zone.text = "Zona %s" % Global.cur_zone[1]
	# find all platforms within the current area
	for p in DataHandler.data.size():
		var id = int(DataHandler.data[p]["ccodice"])
		var area = DataHandler.get_value(id, "czona")
		area = DataHandler.format_string(area)
		if area == Global.cur_zone:
			platforms.append(DataHandler.data[p])
	# get the texture buttons
	for node in columns.get_children():
		if not "Btn" in node.name:
			buttons.append(node)
	# generate the first row
	fill_row()
	# connect the buttons' pressed signal
	for b in buttons.size():
		buttons[b].connect("pressed", platform_infos, "show_info",
						   [buttons[b].platform_id])
	# update max page info
	pages = platforms.size() / buttons.size()
	if platforms.size() % buttons.size() > 0:
		pages += 1
	page.text = "1/%s" % str(pages)
	# show first platform's info for starting
	cur_id = int(platforms[0]["ccodice"])
	platform_infos.show_info(cur_id)

func fill_row():
	var sizes = []
	# find 5 platforms in the json
	for p in range(number, number + buttons.size()):
		var i = p % buttons.size()
		if p < platforms.size():
			buttons[i].modulate.a = 1
			buttons[i].disabled = false
			cur_id = int(platforms[p]["ccodice"])
			var size = DataHandler.get_value(cur_id, "cdimensioni")
			size = DataHandler.format_dimensions(size)
			sizes.append(size)
			# update the buttons
			if sizes[i] < 1000:
				buttons[i].texture_normal = load(textures[0])
				buttons[i].platform_id = cur_id
			elif sizes[i] >= 1000 and sizes[i] < 1500:
				buttons[i].texture_normal = load(textures[1])
				buttons[i].platform_id = cur_id
			else:
				buttons[i].texture_normal = load(textures[2])
				buttons[i].platform_id = cur_id
		else:
			buttons[i].modulate.a = 0
			buttons[i].disabled = true
	# set the first button as active
	buttons[0].pressed = true
	buttons[0].emit_signal("pressed")
	# display the correct info
	platform_infos.show_info(buttons[0].platform_id)

func _on_BtnRight_pressed():
	# play the animation
	$AnimationPlayer.play("swipe")
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
	# pass the new ids to the buttons
	for b in buttons.size():
		buttons[b].disconnect("pressed", platform_infos, "show_info")
		buttons[b].connect("pressed", platform_infos, "show_info",
					   [buttons[b].platform_id])

func _on_BtnLeft_pressed():
	# play the animation
	$AnimationPlayer.play("swipe")
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
	# pass the new ids to the buttons
	for b in buttons.size():
		buttons[b].disconnect("pressed", platform_infos, "show_info")
		buttons[b].connect("pressed", platform_infos, "show_info",
					   [buttons[b].platform_id])

func _on_Play_pressed():
	$PlaySound.play()

func _on_PlaySound_finished():
	# find the pressed button
	for b in buttons.size():
		if buttons[b].pressed:
			cur_id = buttons[b].platform_id
	# switch to the game scene
	Global.platform_id = cur_id
	get_tree().change_scene(map)








