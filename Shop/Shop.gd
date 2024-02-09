extends StaticBody2D
var player

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		%ShopOverlay.visible = true
		player = body

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		%ShopOverlay.visible = false

func _ready():
	var children = %ShopOverlay/Control/ShopBackground.get_children()
	for child in children:
		child.connect("shopItemSold",shopItemEffect)

func shopItemEffect(name):
	var timer:Timer =player.get_node("RoundTimer")
	if(name == "AtkSpeed"):
		var weapon = player.get_node("Keyboard")
		weapon.setAttackSpeed()
	if(name =="AtkDmg"):
		var weapon = player.get_node("Keyboard")
		weapon.setAttackDmg()
	timer.start()
		
