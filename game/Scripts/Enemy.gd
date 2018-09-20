extends KinematicBody2D

var speed = 350
var nav = null setget set_nav
var path = []
var goal = Vector2()
var life = 500
var damage = 50
var start_pos = 0
var final_pos = 0
var points = 100

var is_swordfish = false
var red_texture = preload("res://Assets/Art/UI/red_button00.png")

func _ready():
	var active_pits = get_parent().get_node("Platform").producting_pits
	damage = (Global.initial_life / 12) + (active_pits * 20)
	speed += (active_pits) * 10
	$HealthBar.max_value = self.life
	$HealthBar.value = $HealthBar.max_value
	if is_swordfish:
		life += (life / 3)
		speed -= 50
		damage *= 2
		points *= 2
		$Sprite.animation = "dolphin"
	# start the timer
	start_pos = position.x
	$Timer.start()

func set_nav(new_nav):
	nav = new_nav
	path = nav.get_simple_path(global_position, goal, false)

func _physics_process(delta):
	# update healthbar
	$HealthBar.value = self.life
	# travel to the next point
	if path.size() > 1:
		var d = global_position.distance_to(path[0])
		if d > 6:
			global_position = global_position.linear_interpolate(path[0], 
					(speed * delta) / d)
		else:
			path.remove(0)
	else:
		queue_free()

func hit(damage):
	# check remaining life
	if life > damage:
		life -= damage
		Global.money += 2
	else:
		life = 0
		explode()

func explode():
	$ExplosionSound.play()
	$CollisionShape2D.disabled = true
	speed = 0
	$AnimationPlayer.play("explode")
	Global.money += points

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

func _on_HealthBar_value_changed(value):
	if value <= $HealthBar.max_value / 4:
		$HealthBar.texture_progress = red_texture

func _on_Timer_timeout():
	final_pos = position.x
	# check direction
	if final_pos < start_pos:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

	start_pos = position.x



