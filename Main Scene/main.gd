extends Node2D

var randNumb_generate = RandomNumberGenerator.new()
var ladybug = preload("res://Enemy/Ladybug/Ladybug.tscn")
var shop = preload("res://Shop/Shop.tscn")
@onready var roundTimer: Timer = $RoundTimer
@onready var roundLabel: Label = $RoundGlock
var fightmode= true
var enemys: Array


func _ready():
	enemys.push_back(ladybug)
	var round_Timer = get_node("Player/RoundTimer")
	round_Timer.connect("timeout",roundEnd)
	if(get_node("GameMenu").visible):
		get_tree().paused = true
	
func spawn_mob():
	var randomMobInstace = get_randomMob()
	%MobPath.progress_ratio = randf()
	randomMobInstace.global_position = %MobPath.global_position
	add_child(randomMobInstace)
	
func get_randomMob():
	var enemyNumber = enemys.size()
	var randomNumber:int = randNumb_generate.randi_range(0,enemyNumber-1)
	return enemys[randomNumber].instantiate()


func _on_timer_timeout():
	%SpawnTimer.wait_time = randf_range(0.4,0.7)
	if fightmode:
		spawn_mob()

func roundEnd():
	fightmode=false
	var Enemys = get_tree().get_nodes_in_group("Enemys")
	for enemy in Enemys:
		enemy.queue_free()
	var newShop = shop.instantiate()
	newShop.position = Vector2(-150.0,-150.0)
	add_child(newShop)
	#Create Shopping overview
	#Create Shopping items



func _on_button_pressed():
	get_tree().reload_current_scene()
	


func _on_start_game_button_pressed():
	get_tree().paused = false
	%GameMenu.visible = false
