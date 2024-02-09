extends Area2D
var keyboardAnimation: AnimatedSprite2D
const KEYBOARDBULLET = preload("res://Player/weapon/rgb_bullet.tscn")
var canAttk
var attkSpeed
@onready var dmg =1

func _ready():
	keyboardAnimation = $Pivot/Keyboard
	keyboardAnimation.animation = "RGBRotation"



func _physics_process(delta):
	if not keyboardAnimation.is_playing():
		keyboardAnimation.play(keyboardAnimation.animation)	

	
	if Input.is_action_pressed("shoot") && canAttk:
		canAttk=false
		shootBullet()
		
	
	var mousePosition = get_global_mouse_position()
	look_at(mousePosition)

func shootBullet():
	var bullet = KEYBOARDBULLET.instantiate()
	bullet.attkdmg = dmg
	bullet.global_position = $Pivot/Keyboard/ShootingPoint.global_position
	bullet.global_rotation = $Pivot/Keyboard/ShootingPoint.global_rotation-1.55
	$Pivot/Keyboard/ShootingPoint.add_child(bullet)
func setAttackDmg():
	dmg+=1
func setAttackSpeed():
	$Pivot/Keyboard/Timer.wait_time += -0.2

func _on_timer_timeout():
	canAttk = true
