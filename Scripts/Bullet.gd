extends Area2D

var speed = 1000
var velocity = Vector2()
var damage = 2

func start(pos, dir):
	position = Vector2()
	rotation = dir
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	position += velocity * delta

func _on_Bullet_body_entered(body):
	body.hit(damage)
	queue_free()