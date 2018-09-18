extends KinematicBody2D

export (int) var detect_radius
export (float) var fire_rate
export (PackedScene) var Bullet
var vis_color = Color(.867, .91, .247, 0.1)

onready var size setget set_size
var targets = []
var can_shoot = true
var damage = 10

func _ready():
	$Spawn.play()
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	$Visibility/CollisionShape2D.shape = shape
	$ShootTimer.wait_time = fire_rate

func set_size(new_size):
	size = new_size
	if size == "Small":
		detect_radius = 300
		fire_rate = 0.2
	elif size == "Medium":
		detect_radius = 500
		fire_rate = 0.4
	elif size == "Big":
		detect_radius = 200
		fire_rate = 0.1
		damage = 15

func _physics_process(delta):
	update()
	if targets.size() > 0:
		if can_shoot:
			shoot(targets.front().position)

func shoot(pos):
	var b = Bullet.instance()
	var a = (pos - global_position).angle()
	b.damage = self.damage
	b.start($Sprite/Muzzle.position, a + rand_range(-0.05, 0.05))
	get_parent().add_child(b)
	can_shoot = false
	$ShootTimer.start()
	$Gunshot.play()

func _draw():
	draw_circle(Vector2(), detect_radius, vis_color)

func _on_Visibility_body_entered(body):
	targets.append(body)

func _on_Visibility_body_exited(body):
	targets.erase(body)

func _on_ShootTimer_timeout():
	can_shoot = true
