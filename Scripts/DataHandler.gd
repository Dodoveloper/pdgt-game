extends Node

const DATA_PATH = "res://Data/Elenco-piattaforme-marine.json"
var data

func _ready():
	# try to load the file
	var file = File.new()
	if not file.file_exists(DATA_PATH):
		print("data absent!")
		return
	# read the file and store it into a dictionary
	file.open(DATA_PATH, File.READ)
	var json = JSON.parse(file.get_as_text())
	data = json.result
#	for i in data.size():
#		print(data[i].cdimensioni)
#	get_platform_pit("LUNA A")

func get_platform_size(platform_name):
	# get the right index
	var index
	for i in data.size():
		if platform_name == data[i].cdenominazione__:
			index = i
			break
	# get the size values
	if data[index].cdimensioni == "" or data[index].cdimensioni == null:
		print("The platform has no specified size")
		return
	else:
		# get the string and convert it
		var platform_size = data[index].cdimensioni
		platform_size = platform_size.replacen("x", "")
		platform_size = platform_size.replacen("m", "")
		var n1 = platform_size.left(3).to_int()
		var n2 = platform_size.right(3).to_int()
		print(platform_size, " ", n1, " ", n2, " ", n1*n2)
		return n1*n2

func get_platform_pit(platform_name):
	var index
	for i in data.size():
		if platform_name == data[i].cdenominazione__:
			index = i
			break
	# get the value
	if data[index].cpozzi_in_produzione == "" or data[index].cpozzi_in_produzione == null:
		print("The platform has no specified pits")
	else:
		# get the string and convert it
		var pit_count = data[index].cpozzi_in_produzione.to_int()
		print(pit_count)
		return pit_count

func get_mineral(platform_name):
	var index
	for i in data.size():
		if platform_name == data[i].cdenominazione__:
			index = i
			break
	# get the value
	if data[index].cminerale == "" or data[index].cminerale == null:
		print("The platform has no specified mineral")
	else:
		# get the string and convert it
		var mineral = data[index].cminerale
		print(mineral)
		return mineral





