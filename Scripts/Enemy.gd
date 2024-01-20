class_name Enemy extends CharacterBody2D

@export var SPEED = 50
@export var health = 10
var EXPLOSION_EFFECT = preload("res://Scenes/Explosion.tscn")
#@export var initial_vel = Vector2(0, 50)
@onready var enemy = $"."
@onready var enemy_sprite= $AnimatedSprite2D
@onready var collider = $CollisionShape2D

func _ready():
	enemy_sprite.visible = true
	collider.disabled = false
	#velocity = initial_vel
	velocity = Vector2(transform.y * SPEED)
	
func hit_by_projectile(damage):
	health -= damage
	if health <= 0:
		print("Enemy died")
		# play explosion particle
		var effect = EXPLOSION_EFFECT.instantiate()
		add_child(effect)
		effect.global_position = enemy.global_position
		# make enemy invisible for explosion animation
		enemy_sprite.visible = false
		collider.disabled = true
		# wait lifetime of explosion particles
		await get_tree().create_timer(2).timeout
		# destroy enemy
		queue_free()

func _physics_process(delta):
	#move_and_collide(transform.y * SPEED * delta)
	var collision = move_and_collide(velocity * delta)

	if collision:
		# check if player collided with enemy
		if	collision.get_collider().get_meta("Type") == "Player":
			collision.get_collider().die()
