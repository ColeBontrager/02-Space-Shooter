extends KinematicBody2D


export (int) var speed = 200

var velocity = Vector2.ZERO

var bullet = preload("res://Bullet/Bullet.tscn")
var bullets = null
var fireTime = .16
var curTime = 0
var health = 10
var firing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	takeDamage(0)

func takeDamage(damage):
	health -= damage
	var healthLabel = get_node_or_null("/root/Game/HUD/Health")
	healthLabel.text = "Health: "+str(health)
	if health <= 0:
		var _scene = get_tree().change_scene("res://Menu/Die.tscn")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	curTime -= delta
	if curTime <= 0:
		curTime = fireTime
		if firing:
			fireBullet()
	look_at(get_global_mouse_position())
	rotate(deg2rad(90))

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("Down"):
		velocity.y += 1
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Right"):
		velocity.x += 1
	velocity = velocity.normalized() * speed
		
func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	
	if Input.is_action_pressed("Fire"):
		firing = true
	else:
		firing = false
	
		
		
func fireBullet():
	print("fire")
	if bullets == null:
		bullets = get_node_or_null("/root/Game/Bullets")
	if bullets != null:
		var tempBullet = bullet.instance()
		tempBullet.position = position
		tempBullet.rotation = rotation
		bullets.add_child(tempBullet)
		
