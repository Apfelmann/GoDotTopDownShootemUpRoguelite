extends StaticBody2D

var shopItems = preload("res://Shop/ShopItem/ShopItem.tscn")

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		%ShopOverlay.visible = true
		shopItems.instantiate()



#func _on_area_2d_body_exited(body):
	#if body.name == "Player":
		#%ShopOverlay.visible = false

