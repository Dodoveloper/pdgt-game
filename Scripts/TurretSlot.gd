extends TextureButton

var Menu = preload("res://Scenes/TurretPopup.tscn")
var menu
var Turret = preload("res://Scenes/Turret.tscn")

func _on_TurretSlot_pressed():
	# display the popup menu
	menu = Menu.instance()
	menu.get_node("PanelContainer").rect_position = rect_position + rect_size
	menu.connect("turret_requested", self, "spawn_turret")
	add_child(menu)

func spawn_turret(size):
	var t = Turret.instance()
	t.position = rect_position - (rect_size / 2) - Vector2(128, 0)
	add_child(t)
	# hide the menu and the slot
	menu.queue_free()
	self.disabled = true