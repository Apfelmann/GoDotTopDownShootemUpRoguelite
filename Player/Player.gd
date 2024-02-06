extends CharacterBody2D

@export var speed =  200
@export var dashSpeed = 15000
@export var maxHealth = 5
var playerHealthBar : PlayerHealthBar
@onready var displayMoney = load("res://UI/Money/DisplayCoin.tscn")
@onready var timer: Timer = $RoundTimer
@onready var roundLabel: Label = $RoundGlock

func _ready():
	playerHealthBar = PlayerHealthBar.new(maxHealth)
	playerHealthBar.position = Vector2(-350,-185)
	%PlayerView.add_child(playerHealthBar)
	var instanceDisplayMoney = displayMoney.instantiate()
	instanceDisplayMoney.global_position = Vector2(300,-195)
	%PlayerView.add_child(instanceDisplayMoney)

func determine_direction(vector: Vector2) -> String:
	var angle = vector.angle()
	angle = rad_to_deg(angle)
	if angle > -22.5 and angle <= 22.5:
		return "O"
	elif angle > 22.5 and angle <= 67.5:
		return "SE"
	elif angle > 67.5 and angle <= 112.5:
		return "S"
	elif angle > 112.5 and angle <= 157.5:
		return "SW"
	elif angle > 157.5 or angle <= -157.5:
		return "W"
	elif angle > -157.5 and angle <= -112.5:
		return "NW"
	elif angle > -112.5 and angle <= -67.5:
		return "N"
	elif angle > -67.5 and angle <= -22.5:
		return "NE"
	else:
		return "UNKNOWN"

func getInput():
	var inputDirection = Input.get_vector("left","right","up","down")

	if(Input.is_action_just_pressed("dash")):
		while dashSpeed>=speed:
			velocity = inputDirection *  dashSpeed
			dashSpeed += -12000
		dashSpeed=12000
	else:
		velocity = inputDirection * speed
	
	var direction = determine_direction(velocity)
	if velocity.x ==0 && velocity.y==0:
		$NerdCharakter.animation = "Idle"
	else:
		if direction == "SE":
			$NerdCharakter.animation = "SO"
		elif direction == "NW":
			$NerdCharakter.animation = "NW"
		elif velocity.x > 0 and velocity.y == 0:
			$NerdCharakter.animation = "O"
		else:
			match direction:

				"NE":
					$NerdCharakter.animation = "NO"
				"N":
					$NerdCharakter.animation = "N"
				"W":
					$NerdCharakter.animation = "W"
				"SW":
					$NerdCharakter.animation = "SW"
				"S":
					$NerdCharakter.animation = "S"
				"UNKNOWN":
					$NerdCharakter.animation = "IDLE"
	
	$NerdCharakter.play($NerdCharakter.animation)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func take_damage(dmg):
	playerHealthBar.decrreaseHealth()

func _physics_process(delta):
	roundLabel.text = str(int(timer.time_left))
	getInput()
	move_and_slide()
	


