extends CharacterBody2D


@onready var player = get_node("/root/Main/Player")
@onready var health = 1
@export var speed = 150
var ladyBugCharakter : AnimatedSprite2D
signal onDeath(coin)

func _ready():
	add_to_group("Enemys")
	ladyBugCharakter = $Ladybug_animation
	ladyBugCharakter.animation="default"

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	if not ladyBugCharakter.is_playing():
		ladyBugCharakter.play(ladyBugCharakter.animation)
	velocity = direction * speed
	move_and_slide()
	
func take_damage_enemy(dmg):
	health -= dmg
	if health <=0:
		onDeath.emit(1)
		queue_free()

func _on_hurt_box_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(1)
