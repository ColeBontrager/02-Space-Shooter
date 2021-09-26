extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemy1 = preload("res://Enemies/Enemy1/Enemy1.tscn")
var enemy2 = preload("res://Enemies/Enemy2/Enemy2.tscn")
var enemies = null
var player = null
export (float) var maxSpawnTime = 3
export (float) var minSpawnTime = 1
var curTime = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	enemies = get_node_or_null("/root/Game/Enemies")
	player = get_node_or_null("/root/Game/Player")

func _process(delta):
	curTime -= delta
	if curTime <= 0:
		curTime = rand_range(1, 3)
		var z = randi() % 3
		if z > 0:
			spawnEnemy()
		if z > 1:
			spawnEnemy()
		spawnEnemy()
		
		
		
func spawnEnemy():
	print("sapwd")
	var x = (randi() % 965) + 30
	var y = (randi() % 541) + 30
	var z = randi() % 2
	var enemy = enemy1
	if z == 0:
		enemy = enemy2
	var e = enemy.instance()
	e.position = Vector2(x, y)
	enemies.add_child(e)
	

		
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
