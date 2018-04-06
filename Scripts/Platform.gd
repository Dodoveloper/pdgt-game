extends Area2D

var id = 290# platform's name
var life
var producting_pits
var inactive_pits
var size
var location = Vector2()
# info stuff
var info_dict = {
	"name" : "",
	"year" : "",
	"type" : "",
	"mineral" : "",
	"owner" : "",
	"unmig_section" : "",
	"harbormaster" : "",
	"distance" : "",
	"altitude" : "",
	"depth" : "",
	"dimensions" : ""
}

func _ready():
	init(id)
	for key in info_dict.keys():
		print(info_dict[key])

func init(id):
	info_dict.name = DataHandler.get_value(id, "cdenominazione__")
	info_dict.mineral = DataHandler.get_value(id, "cminerale")
	info_dict.altitude = DataHandler.get_value(id, "caltezza_slm__m_")
	info_dict.depth = DataHandler.get_value(id, "cprofondit__fondale__m_")
	info_dict.dimensions = DataHandler.get_value(id, "cdimensioni")