extends KinematicBody2D

export (int) var detect_radius
export (float) var fire_rate
export (PackedScene) var Bullet
var vis_color = Color(.867, .91, .247, 0.1)

onready var size setget set_size
var targets = []
var can_shoot = true

func _ready():
	$Sprite.self_modulate = Color(0.2, 0, 0)
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	$Visibility/CollisionShape2D.shape = shape
	$ShootTimer.wait_time = fire_rate

func set_size(new_size):
	size = new_size
	if size == "Small":
		detect_radius = 150
		fire_rate = 0.3
	elif size == "Medium":
		detect_radius = 250
		fire_rate = 0.2
	elif size == "Big":
		detect_radius = 450
		fire_rate = 0.4

func _physics_process(delta):
	update()
	if targets.size() > 0:
		rotation = (targets[0].position - position).angle()
		if can_shoot and targets[0]:
			shoot(targets[0].position)

func shoot(pos):
	var b = Bullet.instance()
	var a = (pos - global_position).angle()
	b.start(position, a + rand_range(-0.05, 0.05))
	get_parent().add_child(b)
	can_shoot = false
	$ShootTimer.start()

func _draw():
	draw_circle(Vector2(), detect_radius, vis_color)

func _on_Visibility_body_entered(body):
	# if already targeting, store the second target to shoot it later
	if targets.size() > 0 and targets[0]:
		targets.append(body)
		return
#	print("Targeting ", String(body.name))
	targets.append(body)
	$Sprite.self_modulate.r = 1.0

func _on_Visibility_body_exited(body):
	if body == targets[0]:
#		print("Destroyed ", String(body.name))
		targets.pop_front()
		$Sprite.self_modulate.r = 0.2

func _on_ShootTimer_timeout():
	can_shoot = true
