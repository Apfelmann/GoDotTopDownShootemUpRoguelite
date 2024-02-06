extends Node2D
class_name DisplayCoin
@onready var coinAnimation:AnimatedSprite2D = $Coin
@onready var coinLabel:Label = $Label
@onready var coinValue:int= 0 

func _ready():
	coinLabel.text = "0"
	coinAnimation.animation = "default"
	coinAnimation.play(coinAnimation.animation)

	
func _process(delta):
	var ladybugs = get_tree().get_nodes_in_group("Enemys")
	for ladybug in ladybugs:
		ladybug.connect("onDeath", changeValue)
	

func changeValue(coin):
	coinValue += coin
	coinLabel.text = str(coinValue)
