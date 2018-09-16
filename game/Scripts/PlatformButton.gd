extends TextureButton

var platform_id = 0

func _ready():
	pass

func _on_PlatformButton_pressed():
	if pressed:
		$Sound.play()
		$AnimationPlayer.play("active")
		var buttons = []
		for node in get_parent().get_children():
			if "PlatformButton" in node.name and not node.name == name:
				buttons.append(node)
		for btn in buttons:
			btn.pressed = false
			btn.emit_signal("pressed")
	else:
		$AnimationPlayer.play("default")