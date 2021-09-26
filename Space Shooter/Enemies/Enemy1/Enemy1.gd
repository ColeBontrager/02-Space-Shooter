extends KinematicBody2D


export (int) var health = 3
export var rotateSpeed = 90
var waiting = true
export (float) var waitTime = 1.8
var curWaitTime = 0

var bullet = preload("res://Enemy Bullet/EnemyBullet.tscn")
var bullets = null
var deathParticles = preload("res://Enemies/EnemyDeathParticles.tscn")

func _ready():
	curWaitTime = waitTime
	
func _process(delta):
	if waiting:
		curWaitTime -= delta
		if curWaitTime <= 0:
			waiting = false
	else:
		curWaitTime = waitTime
		fireBullets()
		waiting = true
		
func _physics_process(delta):
	rotate(deg2rad(rotateSpeed) * delta)
	
		
func takeDamage(damage):
	health -= damage
	if health <= 0:
		die()
func fireBullets():
	if bullets == null:
			bullets = get_node_or_null("/root/Game/Bullets")
	if bullets != null:
		var bullet1 = bullet.instance()
		bullet1.position = position
		bullet1.rotation = rotation
		bullets.add_child(bullet1)
		var bullet2 = bullet.instance()
		bullet2.position = position
		bullet2.rotation = rotation + deg2rad(90)
		bullets.add_child(bullet2)
		var bullet3 = bullet.instance()
		bullet3.position = position
		bullet3.rotation = rotation + deg2rad(180)
		bullets.add_child(bullet3)
		var bullet4 = bullet.instance()
		bullet4.position = position
		bullet4.rotation = rotation + deg2rad(270)
		bullets.add_child(bullet4)
		
	
	
func die():
	var score = get_node_or_null("/root/Game/HUD/Score")
	score.updateScore(2)
	var particles = get_node_or_null("/root/Game/Particles")
	var particle = deathParticles.instance()
	particle.position = position
	particles.add_child(particle)
	queue_free()
