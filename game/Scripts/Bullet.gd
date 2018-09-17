extends Area2D

var speed = 2000
var velocity = Vector2()
var damage = 2

func start(pos, dir):
	position = pos
	rotation = dir
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	position += velocity * delta

func _on_Bullet_body_entered(body):
	# damage the enemies
	body.hit(damage)
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
