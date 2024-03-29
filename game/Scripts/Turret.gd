extends KinematicBody2D

export (int) var detect_radius
export (float) var fire_rate
export (PackedScene) var Bullet
var vis_color = Color(.867, .91, .247, 0.1)

onready var size setget set_size
var targets = []
var can_shoot = true
var damage = 14

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
		fire_rate = 0.25
		$Sprite.modulate = Color("ff9595")
	elif size == "Medium":
		detect_radius = 400
		fire_rate = 0.2
		$Sprite.modulate = Color("ffda95")
	elif size == "Big":
		detect_radius = 200
		fire_rate = 0.1
		$Sprite.modulate = Color("a9eeff")
		damage += (damage / 2)

func _physics_process(_delta):
	update()
	if targets.size() > 0:
		if can_shoot:
			shoot(targets.front().position)

func shoot(pos):
	var b = Bullet.instance()
	var a = (pos - global_position).angle()
	b.damage = self.damage
	b.start($Sprite/Muzzle.position, a + rand_range(-0.02, 0.02))
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
