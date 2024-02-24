extends Node2D
const texture1= preload("res://Assets/Background/BG1.png")

var texture_count_x = 0
var texture_count_y = 0
var rotationVals = [90, 180, 270]

var sprites = []
var scroll_speed = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_size = get_viewport_rect().size
	
	# calculate # of textures needed for x and y
	texture_count_x = 40
	texture_count_y = 40
	#texture_count_x = ceil(viewport_size.x / 64)
	#texture_count_y = ceil(viewport_size.y / 64)
	
	for x in range (texture_count_x):
		for y in range (texture_count_y):
			var sprite_instance = Sprite2D.new()
			sprite_instance.texture = texture1
			sprite_instance.position = Vector2(x * 64, y * 64)
			sprite_instance.rotation_degrees = rotationVals[randi() % rotationVals.size()]
			add_child(sprite_instance)
			sprites.append(sprite_instance)
			
#func _process(delta):
	## Scroll the background vertically
	#for sprite in sprites:
		#sprite.position.y += scroll_speed * delta
##
		## Reset the position when the sprite goes off the screen
		#if sprite.position.y > get_viewport_rect().size.y:
			#sprite.position.y -= get_viewport_rect().size.y	
