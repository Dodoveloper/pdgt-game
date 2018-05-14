extends KinematicBody2D

export (float) var fire_rate
export (PackedScene) var Bullet
export (int) var speed

var nav = null setget set_nav
var path = []
var goal = Vector2()
var life = 30
# shooting params
var can_shoot = true
var target
var accuracy = 0.18

func set_nav(new_nav):
	nav = new_nav
	path = nav.get_simple_path(global_position, goal, false)

func _physics_process(delta):
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
	# shooting code
	if can_shoot and target:
		shoot(target.global_position)

func shoot(pos):
	var b = Bullet.instance()
	var a = (pos - global_position).angle()
	b.start(position, a + rand_range(-accuracy, accuracy))
	get_parent().add_child(b)
	can_shoot = false
	$ShootTimer.start()

func _on_Scan_area_entered( area ):
	print("%s entered" %area.name)
	# stop moving and start shooting
	speed = 0
	target = area

func _on_Scan_area_exited(area):
	target = null

func hit(damage):
	# check remaining life
	if life > damage:
		life -= damage
	else:
		queue_free()

func _on_ShootTimer_timeout():
	can_shoot = true


