extends Node2D
class_name PlayerHealthBar

signal killed
	
	
var maxHealth
var currentHealth
var heartPosition
var hearts : Array

func _init(startHealth):
	maxHealth = startHealth
	currentHealth = startHealth
	heartPosition = 0
	hearts = []
	
	
	for n in startHealth:
		increasHealth()
	
	
func increasHealth():
		if(hearts.size() < maxHealth):
			var heart = Sprite2D.new()
			heart.texture=preload("res://Player/PlayerHealthBar/Hearth.aseprite")
			heart.position = Vector2(heartPosition, 0)
			heart.scale = Vector2(1.5,1.5)
			heartPosition += 8
			hearts.append(heart)
			add_child(heart)
	
func decrreaseHealth():
	remove_child(hearts.pop_back())
	heartPosition -= 40
	if(hearts.is_empty()):
		var GameOverNode:CanvasLayer = get_node("/root/Main/GameOver")
		GameOverNode.visible = true
		get_tree().paused = true
