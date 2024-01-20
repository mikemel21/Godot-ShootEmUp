class_name Player extends CharacterBody2D

const SPEED = 500.0

var shotTimer = 0.25
var hasShot = false

@onready var player = $"."
@onready var player_spr = $Sprite2D
@onready var thrust_spr = $AnimatedSprite2D
@onready var player_collider = $CollisionShape2D
@onready var shot_timer = $shotTimer
@onready var barrel = $Barrel
@onready var player_projectile = preload("res://Scenes/Player-Projectile.tscn")
@onready var shotSound = $AudioStreamPlayer2D
var EXPLOSION_EFFECT = preload("res://Scenes/Explosion.tscn")

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * SPEED
	
	if Input.is_action_pressed("Shoot"):
		Shoot()

func Shoot():
	if !hasShot:
		hasShot = true
		shotSound.play()
		var projectile = player_projectile.instantiate()
		#owner.add_child(projectile)
		get_tree().root.add_child(projectile)
		projectile.transform = barrel.global_transform
		projectile.start()
		await get_tree().create_timer(0.25).timeout
		hasShot = false

func die():
	# play explosion particle
	var effect = EXPLOSION_EFFECT.instantiate()
	add_child(effect)
	effect.global_position = player.global_position
	# make enemy invisible for explosion animation
	player_spr.visible = false
	thrust_spr.visible = false
	player_collider.disabled = true
	# wait lifetime of explosion particles
	await get_tree().create_timer(2).timeout
	# destroy enemy
	queue_free()
	
func _process(delta):
	get_input()
	move_and_collide(velocity * delta)
