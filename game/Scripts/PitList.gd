extends ItemList

onready var platform = get_parent()
# textures
var active = preload("res://Assets/Art/UI/active_well.png")
var inactive = preload("res://Assets/Art/UI/inactive_well.png")
var icons = []

func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	for p in platform.producting_pits:
		add_icon_item(active)
		icons.append(1)
	for i in platform.inactive_pits:
		add_icon_item(inactive)
		icons.append(0)

func _on_PitList_item_activated(index):
	if not icons[index]:
		if Global.decrease_money(Global.pits_cost):
			icons[index] = 1
			set_item_icon(index, active)
		else:
			print("insufficient money to activate a pit")
	else:
		print(index, " already activated")