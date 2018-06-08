extends ItemList

onready var platform = get_parent()
# textures
var active = preload("res://Assets/Art/UI/blue_panel.png")
var inactive = preload("res://Assets/Art/UI/red_panel.png")

func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	for p in platform.producting_pits:
		add_icon_item(active)
	for i in platform.inactive_pits:
		add_icon_item(inactive)