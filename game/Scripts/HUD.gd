extends CanvasLayer

signal weather_acquired

const DATA_PATH = "res://Data/weather.json"
var data
var file = null

onready var platform = get_tree().root.get_node("Map/Platform")
var GameOver = preload("res://Scenes/GameOver.tscn")

var green_texture = preload("res://Assets/Art/UI/green_button00.png")
var yellow_texture = preload("res://Assets/Art/UI/yellow_button00.png")
var red_texture = preload("res://Assets/Art/UI/red_button00.png")

func _ready():
	yield(get_tree().create_timer(0.5), "timeout")
	init_values()
	fill_weather_info()

func init_values():
	$HealthBar.max_value = Global.platform_life
	$HealthBar.value = Global.platform_life
	$Name.text = Global.platform_info.Name

func fill_weather_info():
	# try to load the file
	file = File.new()
	if not file.file_exists(DATA_PATH):
		print("output weather json absent!")
		return
	# read the file and store it into an array of dictionaries
	file.open(DATA_PATH, File.READ)
	var json = JSON.parse(file.get_as_text())
	data = json.result
	# get the values and display them on the HUD
	var temp = data.main.temp
	var description = data.weather[0].description
	$Weather/Generic.text = "%d° %s" % [temp, description]
	var wind = int(data.wind.speed) * 3.6
	$Weather/Wind.text = "vento %d km/h" % wind
	var humidity = data.main.humidity
	$Weather/Humidity.text = "umidità %s %%" % humidity
	# notify the map
	emit_signal("weather_acquired", data.weather[0].main)
	# close the file
	file.close()

func _process(delta):
	$Money.text = String(Global.money) + " €"
	$HealthBar.value = Global.platform_life
	$GasLabel.text = "%d %%" % Global.gas_percentage

func _on_HealthBar_value_changed(value):
	if value <= $HealthBar.max_value / 2:
		$HealthBar.texture_progress = yellow_texture
	if value <= $HealthBar.max_value / 4:
		$HealthBar.texture_progress = red_texture

func _on_GasTimer_timeout():
	# check gas lvl every second
	Global.gas_percentage += Global.gas_increase
	$GasLevel.value = Global.gas_percentage
	# check victory
	if $GasLevel.value >= 100:
		var g = GameOver.instance()
		g.victory = true
		add_child(g)