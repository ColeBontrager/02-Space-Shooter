extends Area2D


export (Vector2) var velocity = Vector2(0, -10)
var particle = preload("res://Bullet/BulletParticles.tscn")
var particles = null

export (int) var damage = 1

func _physics_process(delta):
	position += velocity.rotated(rotation)


func _on_Area2D_body_entered(body):
	if particles == null:
		particles = get_node_or_null("/root/Game/Particles")
	if particles != null:
		var tempParticle = particle.instance()
		tempParticle.position = position
		tempParticle.rotation = rotation
		particles.add_child(tempParticle)
	if body.has_method("takeDamage"):
		body.takeDamage(damage)
	queue_free()
	
