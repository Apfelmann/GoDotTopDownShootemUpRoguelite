extends TextureRect


func _init():
	createAllShopIcons()

func createAllShopIcons():
	var assets = []
	var nextPosition:int
	var nextPositionRow2:int
	var nextRow:int=0
	var dir = DirAccess.open("res://Shop/ShopItem/assets")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name !="":
			assets.push_back(file_name)
			file_name = dir.get_next()
	for asset in assets:
		if(asset.ends_with(".jpg")):
			var name:String =""
			var length = asset.length()-4
			for letter in asset:
				if(length>0):
					name =name+letter
				length-=1
			var shopItemToBuy:Button = Button.new()
			shopItemToBuy.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			shopItemToBuy.size = Vector2(64, 64)
			if(nextRow>4):
				shopItemToBuy.position = Vector2(445,50+nextPositionRow2)
				nextPositionRow2+=74
			else:
				shopItemToBuy.position = Vector2(100,50+nextPosition)
				nextPosition+=74
			shopItemToBuy.text=name
			shopItemToBuy.icon = load('res://Shop/ShopItem/assets/'+asset)
			nextRow+=1
			shopItemToBuy.set_meta("type",name)
			shopItemToBuy.add_user_signal("shopItemSold",[name])
			shopItemToBuy.connect("pressed", func():
				_on_ShopItemButton_pressed(shopItemToBuy))
			add_child(shopItemToBuy)
func _on_ShopItemButton_pressed(button:Button):
	var name = button.get_meta("type")
	button.emit_signal("shopItemSold",name)
	%ShopOverlay.queue_free() 
	
