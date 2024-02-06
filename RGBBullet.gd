extends Area2D
var dmg
var travelled_distance = 0
var RGBBulletAnimation : AnimatedSprite2D

func _init():
	dmg = 1

func _ready():
	RGBBulletAnimation = $RGBBullet
	RGBBulletAnimation.animation = "default"

func _physics_process(delta):
	const SPEED = 1000
	const RANGE = 1200
	
	if not RGBBulletAnimation.is_playing():
		RGBBulletAnimation.play(RGBBulletAnimation.animation)
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance>RANGE:
		queue_free()

func _on_body_entered(body):
	if body.name =="Player":
		return
		
	if body.has_method("take_damage_enemy"):
		body.take_damage_enemy(dmg)
		queue_free()

