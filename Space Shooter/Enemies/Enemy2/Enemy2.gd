extends KinematicBody2D


export (int) var speed = 3
export (int) var health = 2
export (float) var shootTime = 1
var curShootTime = 0
var bullet = preload("res://Enemy Bullet/EnemyBullet.tscn")
var bullets = null
var deathParticles = preload("res://Enemies/EnemyDeathParticles.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	curShootTime = shootTime

func _process(delta):
	curShootTime -= delta
	if curShootTime <= 0:
		curShootTime = shootTime
		fire()
	

func fire():
	if bullets == null:
			bullets = get_node_or_null("/root/Game/Bullets")
	if bullets != null:
		var bullet1 = bullet.instance()
		bullet1.position = position
		bullet1.rotation = rotation
		bullets.add_child(bullet1)

func _physics_process(delta):
	var player = get_node_or_null("/root/Game/Player")
	look_at(player.position)
	rotate(deg2rad(90))
	var direction = (player.position - position).normalized()
	var collision = move_and_collide(direction * speed)
	if collision:
		if collision.collider.has_method("takeDamage"):
			collision.collider.takeDamage(3)
		queue_free()
	
func takeDamage(damage):
	health -= damage
	if health <= 0:
		die()

func die():
	var score = get_node_or_null("/root/Game/HUD/Score")
	score.updateScore(1)
	var particles = get_node_or_null("/root/Game/Particles")
	var particle = deathParticles.instance()
	particle.position = position
	particles.add_child(particle)
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
