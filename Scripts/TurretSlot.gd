extends TextureButton

var Menu = preload("res://Scenes/TurretPopup.tscn")
var menu
var Turret = preload("res://Scenes/Turret.tscn")
# turret's position
onready var pos = $Pivot.position

func _on_TurretSlot_pressed():
	# display the popup menu
	menu = Menu.instance()
	menu.get_node("PanelContainer").rect_position = Vector2()
	menu.connect("turret_requested", self, "spawn_turret")
	add_child(menu)

func spawn_turret(size):
	var t = Turret.instance()
	t.position = pos
	t.size = size
	add_child(t)
	# hide the menu and the slot
	menu.queue_free()
	disabled = true