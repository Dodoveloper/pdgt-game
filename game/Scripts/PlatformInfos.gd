extends MarginContainer

onready var first = $Columns/First
onready var second = $Columns/Second

var start_labels = {
	"Name" : "",
	"Year" : "attiva dal ",
	"Owner" : "gruppo ",
	"Type" : "",
	"Dimensions" : "dimensioni: ",
	"Altitude" : "altezza slm: ",
	"Distance" : "distanza dalla costa: ",
	"Depth" : "profondità fondale: ",
	"Harbormaster" : "capitaneria: "
}

var label_values = {
	"Name" : "",
	"Year" : 0,
	"Type" : "",
	"Owner" : "",
	"Harbormaster" : "",
	"Distance" : 0,
	"Altitude" : 0,
	"Depth" : 0,
	"Dimensions" : 0
}

func _ready():
	pass

func show_info(id):
	print(id)
	## init the info dictionary
	label_values.Name = DataHandler.get_value(id, "cdenominazione__")
	# get and format the Year
	label_values.Year = DataHandler.get_value(id, "canno_costruzione")
	label_values.Year = DataHandler.format_string(label_values.Year)
	# get and format the Type
	label_values.Type = DataHandler.get_value(id, "ctipo")
	label_values.Type = DataHandler.format_string(label_values.Type)
	# get and format the Owner
	label_values.Owner = DataHandler.get_value(id, "coperatore")
	label_values.Owner = DataHandler.format_string(label_values.Owner)
	# get and format the Harbormaster
	label_values.Harbormaster = DataHandler.get_value(id, "ccapitaneria_di_porto")
	label_values.Harbormaster = DataHandler.format_string(label_values.Harbormaster)
	# get the remaining values
	label_values.Distance = DataHandler.get_value(id, "cdistanza_costa___km_")
	label_values.Altitude = DataHandler.get_value(id, "caltezza_slm__m_")
	label_values.Depth = DataHandler.get_value(id, "cprofondit__fondale__m_")
	label_values.Dimensions = DataHandler.get_value(id, "cdimensioni")
	
	for label in first.get_children():
		label.text = start_labels[label.name] + label_values[label.name]
	for label in second.get_children():
		label.text = start_labels[label.name] + label_values[label.name]
		if label.name == "Distance":
			label.text += " km"
		elif label.name in ["Altitude", "Depth"]:
			label.text += " m"







