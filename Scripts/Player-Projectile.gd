class_name Player_Projectile extends CharacterBody2D

var SPEED = 750
var damage = 10

func start ():
	#position = _pos
	velocity = Vector2(transform.x * SPEED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)

	if collision:
		# check if projectile hit the enemy
		#if	collision.get_collider().has_method("hit_by_projectile"):
		if collision.get_collider().get_meta("Type") == "Enemy":
			# call the method in enemy to damage it	
			collision.get_collider().hit_by_projectile(damage)
			# destroy projectile
			queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	# Deletes the bullet when it exits the screen.
	queue_free()
