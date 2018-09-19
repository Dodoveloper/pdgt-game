extends Node

const DATA_PATH = "res://Data/Elenco-piattaforme-marine.json"
var data

func _ready():
	# try to load the file
	var file = File.new()
	if not file.file_exists(DATA_PATH):
		print("data absent!")
		return
	# read the file and store it into an array of dictionaries
	file.open(DATA_PATH, File.READ)
	var json = JSON.parse(file.get_as_text())
	data = json.result
	# close the file
	file.close()

func format_dimensions(size):
	var platform_size = size
	platform_size = platform_size.replacen("x", "")
	platform_size = platform_size.replacen("m", "")
	var n1 = platform_size.left(3).to_int()
	var n2 = platform_size.right(3).to_int()
	return n1*n2

func format_string(string):
	var output = string
	output.erase(output.find("|"), output.length() - output.find("|"))
	return output

func get_value(platform_id, key):
	var index = 0
	# get the right index
	for i in data.size():
		if platform_id == data[i]["ccodice"].to_int():
			index = i 
	# get the value
	if data[index][key] == "" or data[index][key] == null:
		print("the platform has no specified ", key, "!")
		return "0"
	else:
		var value = data[index][key]
		return value




