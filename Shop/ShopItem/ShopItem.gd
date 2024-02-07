extends Node2D

func getAllAssets():
	var assets = []
	var dir = DirAccess.open("res://Shop/ShopItem/assets")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name !="":
			assets.push_back(file_name)
			file_name = dir.get_next()
			
	print(assets)

func _init():
	getAllAssets()
