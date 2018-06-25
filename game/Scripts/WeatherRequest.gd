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
		file.open(DATA_PATH, File.READ_WRITE)
		var json = JSON.parse(file.get_as_text())
		data = json.result
		Global.my_token = data.owm_token
		# close the file
		file.close()
	# check if it's necessary another request based on time
	if check_time():
		platform.connect("platform_initialized", self, "make_request")

func make_request():
	print("request")

func check_time():
	var cur_datetime = OS.get_datetime()
	var can_request = false
	var minute_interval = 10

	# if value is > than current datetime we're sure it can make a request,
	# otherwise if = we need to perform more checks
	if cur_datetime.year > int(data["last_req"].year):
		return true
	elif cur_datetime.year == int(data["last_req"].year):
		if cur_datetime.month > int(data["last_req"].month):
			return true
		elif cur_datetime.month == int(data["last_req"].month):
			if cur_datetime.day > int(data["last_req"].day):
				return true
			elif cur_datetime.day == int(data["last_req"].day):
				if cur_datetime.hour > int(data["last_req"].hour):
					return true
				elif cur_datetime.hour == int(data["last_req"].hour):
					if cur_datetime.minute > (int(data["last_req"].minute) + minute_interval) % 60:
						can_request = true

	return can_request



