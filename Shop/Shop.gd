extends StaticBody2D

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		%ShopOverlay.visible = true



func _on_area_2d_body_exited(body):
	if body.name == "Player":
		%ShopOverlay.visible = false

