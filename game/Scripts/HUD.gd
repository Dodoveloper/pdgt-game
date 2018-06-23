extends CanvasLayer

var green_texture = preload("res://Assets/Art/UI/green_button00.png")
var yellow_texture = preload("res://Assets/Art/UI/yellow_button00.png")
var red_texture = preload("res://Assets/Art/UI/red_button00.png")

func _ready():
	$HealthBar.max_value = Global.platform_life
	$HealthBar.value = Global.platform_life

func _process(delta):
	$Money.text = String(Global.money) + " $"
	$HealthBar.value = Global.platform_life

func _on_HealthBar_value_changed(value):
	if value <= $HealthBar.max_value / 2:
		$HealthBar.texture_progress = yellow_texture
	if value <= $HealthBar.max_value / 4:
		$HealthBar.texture_progress = red_texture
