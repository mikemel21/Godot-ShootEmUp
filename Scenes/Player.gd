extends CharacterBody2D

const SPEED = 500.0

var shotTimer = 0.25
var hasShot = false

@onready var shot_timer = $shotTimer
@onready var barrel = $Barrel
@onready var player_projectile = preload("res://Scenes/Player-Projectile.tscn")
@onready var shotSound = $AudioStreamPlayer2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

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
		owner.add_child(projectile)
		projectile.transform = barrel.global_transform
		await get_tree().create_timer(0.25).timeout
		hasShot = false
	
func _process(delta):
	get_input()
	move_and_slide()
