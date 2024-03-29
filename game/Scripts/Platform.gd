extends Area2D


signal platform_initialized

var GameOver = preload("res://Scenes/GameOver.tscn")
var textures = ["res://Assets/Art/Platforms/pixel_small_platform.png",
				"res://Assets/Art/Platforms/pixel_platform.png",
				"res://Assets/Art/Platforms/pixel_big_platform.png"]
# platform's id
var id: int
var producting_pits
var inactive_pits
var size
var location = Vector2()
# info stuff
var info_dict = {
	"Name" : "",
	"Year" : 0,
	"Type" : "",
	"Mineral" : "",
	"Owner" : "",
	"unmig_section" : "",
	"Harbormaster" : "",
	"Distance" : 0,
	"Altitude" : 0,
	"Depth" : 0,
	"Dimensions" : 0
}


func _ready():
	id = Global.platform_id
	## init the info dictionary
	info_dict.Name = DataHandler.get_value(id, "cdenominazione__")
	# get and format the Year
	info_dict.Year = DataHandler.get_value(id, "canno_costruzione")
	info_dict.Year = DataHandler.format_string(info_dict.Year)
	# get and format the Type
	info_dict.Type = DataHandler.get_value(id, "ctipo")
	info_dict.Type = DataHandler.format_string(info_dict.Type)
	# get the Mineral
	info_dict.Mineral = DataHandler.get_value(id, "cminerale")
	# get and format the Owner
	info_dict.Owner = DataHandler.get_value(id, "coperatore")
	info_dict.Owner = DataHandler.format_string(info_dict.Owner)
	# get and format the unmig_section
	info_dict.unmig_section = DataHandler.get_value(id, "csezione_unmig")
	info_dict.unmig_section = DataHandler.format_string(info_dict.unmig_section)
	# get and format the Harbormaster
	info_dict.Harbormaster = DataHandler.get_value(id, "ccapitaneria_di_porto")
	info_dict.Harbormaster = DataHandler.format_string(info_dict.Harbormaster)
	# get the remaining values
	info_dict.Distance = DataHandler.get_value(id, "cdistanza_costa___km_")
	info_dict.Altitude = DataHandler.get_value(id, "caltezza_slm__m_")
	info_dict.Depth = DataHandler.get_value(id, "cprofondit__fondale__m_")
	info_dict.Dimensions = DataHandler.get_value(id, "cdimensioni")
	## init game values
	# location
	var lat = DataHandler.get_value(id, "clatitudine__wgs84__")
	var long = DataHandler.get_value(id, "clongitudine__wgs_84__")
	location = Vector2(long, lat)
	# size and relative texture
	size = DataHandler.format_dimensions(info_dict.Dimensions)
	if size < 1000:
		$Sprite.texture = load(textures[0])
	elif size >= 1000 and size < 1500:
		$Sprite.texture = load(textures[1])
	else:
		$Sprite.texture = load(textures[2])
	$Sprite.scale *= 1.7
	# life, according to size
	Global.platform_life = size
	Global.initial_life = Global.platform_life
	# pits
	producting_pits = DataHandler.get_value(id, "cpozzi_in_produzione").to_int()
	inactive_pits = DataHandler.get_value(id, "cpozzi_produttivi_non_eroganti").to_int()
	Global.platform_info = info_dict
	emit_signal("platform_initialized", location)


func hit(damage):
	$HitSound.play()
	# check remaining life
	if Global.platform_life > damage:
		Global.platform_life -= damage
	else:
		Global.platform_life = 0
		game_over()


func _on_Platform_body_entered(body):
	if body.is_in_group("enemies"):
		self.hit(body.damage)
		body.queue_free()


func game_over():
	$CollisionShape2D.disabled = true
	# play the explosion
	$AnimationPlayer.play("explode")


func _on_AnimationPlayer_animation_finished(_anim_name):
	# display gameover
	var g = GameOver.instance()
	g.victory = false
	get_parent().get_node("Camera2D/HUD").add_child(g)
