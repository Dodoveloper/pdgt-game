extends Node

const DATA_PATH = "res://Data/my_data.json"
var data
onready var platform = get_tree().root.get_node("Map/Platform")
onready var file

func _ready():
	# get the token if necessary
	if Global.my_token == "":
		# try to load the file
		file = File.new()
		if not file.file_exists(DATA_PATH):
			print("OWM data absent!")
			return
		# read the file and store it into an array of dictionaries
		file.open(DATA_PATH, File.READ)
		var json = JSON.parse(file.get_as_text())
		data = json.result
		Global.my_token = data.owm_token
		# close the file
		file.close()
	# check if it's necessary another request based on time
	if check_time():
		platform.connect("platform_initialized", self, "make_request")

func make_request(location):
	var params = [str(location.x), str(location.y), str(Global.my_token)]
	var req = "http://api.openweathermap.org/data/2.5/weather?lat=%s&lon=%s&units=metric&appid=%s" % params
	print(req)
	$HTTPRequest.request(req)

func check_time():
	var cur_datetime = OS.get_datetime()
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
						return true

	return false

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if result != 0:
		print(body.get_string_from_utf8())
		printerr("HTTPRequest Error: ", result, " ", response_code)
		return

	write_last_request()
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	print(json)

func write_last_request():
	var cur_datetime = OS.get_datetime()
	# write current time in JSON
	data["owm_token"] = Global.my_token
	data["last_req"].year = str(cur_datetime.year)
	data["last_req"].month = str(cur_datetime.month)
	data["last_req"].day = str(cur_datetime.day)
	data["last_req"].hour = str(cur_datetime.hour)
	data["last_req"].minute = str(cur_datetime.minute)
	file = File.new()
	file.open(DATA_PATH, File.WRITE)
	file.store_string(JSON.print(data, "  ", true))
	file.close()



