extends Node

const DATA_PATH = "res://Data/my_data.json"
var data
onready var platform = get_tree().root.get_node("Map/Platform")

func _ready():
	# get the token if necessary
	if Global.my_token == "":
		# try to load the file
		var file = File.new()
		if not file.file_exists(DATA_PATH):
			print("OWM data absent!")
			return
		# read the file and store it into an array of dictionaries
		file.open(DATA_PATH, File.READ)
		var json = JSON.parse(file.get_as_text())
		data = json.result
		# close the file
		file.close()
		Global.my_token = data.owm_token
	# check if it's necessary another request based on time
	print(OS.get_datetime(true))
	platform.connect("platform_initialized", self, "make_request")

func make_request():
	print("success")