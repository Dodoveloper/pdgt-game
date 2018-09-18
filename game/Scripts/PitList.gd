extends ItemList

onready var platform = get_parent()
# textures
var active = preload("res://Assets/Art/UI/active_well.png")
var inactive = preload("res://Assets/Art/UI/inactive_well.png")
var icons = []
var active_tooltip = "Active pit"
var inactive_tooltip = "Inactive pit: %s$ to activate" % Global.pits_cost
var increase = 1.0

func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	# compute the gas percentage increase
	var tot_pits = platform.producting_pits + platform.inactive_pits
	increase /= tot_pits
	for p in platform.producting_pits:
		add_icon_item(active)
		icons.append(1)
		Global.gas_increase += (increase / 2)
		# increase enemies' life
		enhance_enemies(100)
	for i in platform.inactive_pits:
		add_icon_item(inactive)
		icons.append(0)

func _on_PitList_item_activated(index):
	if not icons[index]:
		if Global.decrease_money(Global.pits_cost):
			icons[index] = 1
			set_item_icon(index, active)
			Global.gas_increase += increase
			# increase enemies' life
			enhance_enemies(300)
			$ActivatedSound.play()
		else:
			$DeniedSound.play()
	else:
		print(index, " already activated")

func enhance_enemies(factor):
	var nodes = get_tree().root.get_node("Map").get_children()
	for node in nodes:
		if node.is_in_group("enemies"):
			node.life += factor


