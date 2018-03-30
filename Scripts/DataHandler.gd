extends Node

const DATA_PATH = "res://Data/Elenco-piattaforme-marine"

func _ready():
	# try to load the file
	var file = File.new()
	if not file.file_exists(DATA_PATH):
		print("data absent!")
		return
	# read the file and store it into a dictionary
	file.open(DATA_PATH, File.READ)
	var data = {}
	data.parse_json(file.get_as_text())
	print(data)

func read_size(name):
	pass