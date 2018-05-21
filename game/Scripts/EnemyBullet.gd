extends "res://Scripts/Bullet.gd"

func _ready():
	# override damage
	damage = 10
	pass

func _on_EnemyBullet_area_entered( area ):
	# damage the platform
	if area.name == "Platform":
		area.hit(damage)
		queue_free()
