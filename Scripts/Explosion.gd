extends GPUParticles2D

func _ready():
	one_shot = true

func _On_Timer_timeout():
	queue_free()
