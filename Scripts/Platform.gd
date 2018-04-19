extends Area2D

# platform's id
var id = 220
var life
var producting_pits
var inactive_pits
var size
var location = Vector2()
# info stuff
var info_dict = {
	"name" : "",
	"year" : 0,
	"type" : "",
	"mineral" : "",
	"owner" : "",
	"unmig_section" : "",
	"harbormaster" : "",
	"distance" : 0,
	"altitude" : 0,
	"depth" : 0,
	"dimensions" : 0
}

func _ready():
	init(id)
	print(producting_pits, " " , inactive_pits , " " , size , " " , location)
	pass

func init(id):
	## init the info dictionary
	info_dict.name = DataHandler.get_value(id, "cdenominazione__")
	# get and format the year
	info_dict.year = DataHandler.get_value(id, "canno_costruzione")
	info_dict.year = DataHandler.format_string(info_dict.year)
	# get and format the type
	info_dict.type = DataHandler.get_value(id, "ctipo")
	info_dict.type = DataHandler.format_string(info_dict.type)
	# get the mineral
	info_dict.mineral = DataHandler.get_value(id, "cminerale")
	# get and format the owner
	info_dict.owner = DataHandler.get_value(id, "coperatore")
	info_dict.owner = DataHandler.format_string(info_dict.owner)
	# get and format the unmig_section
	info_dict.unmig_section = DataHandler.get_value(id, "csezione_unmig")
	info_dict.unmig_section = DataHandler.format_string(info_dict.unmig_section)
	# get and format the harbormaster
	info_dict.harbormaster = DataHandler.get_value(id, "ccapitaneria_di_porto")
	info_dict.harbormaster = DataHandler.format_string(info_dict.harbormaster)
	# get the remaining values
	info_dict.distance = DataHandler.get_value(id, "cdistanza_costa___km_")
	info_dict.altitude = DataHandler.get_value(id, "caltezza_slm__m_")
	info_dict.depth = DataHandler.get_value(id, "cprofondit__fondale__m_")
	info_dict.dimensions = DataHandler.get_value(id, "cdimensioni")
	
	## init game values
	# location
	var lat = DataHandler.get_value(id, "clatitudine__wgs84__")
	var long = DataHandler.get_value(id, "clongitudine__wgs_84__")
	location = Vector2(long, lat)
	# size
	size = DataHandler.format_dimensions(info_dict.dimensions)
	# life, according to size
	# wip
	# pits
	producting_pits = DataHandler.get_value(id, "cpozzi_in_produzione").to_int()
	inactive_pits = DataHandler.get_value(id, "cpozzi_produttivi_non_eroganti").to_int() + DataHandler.get_value(id, "cpozzi_in_monitoraggio").to_int()

