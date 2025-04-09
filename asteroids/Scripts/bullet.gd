extends CharacterBody2D

@export var speed: float = 1000.0

func _physics_process(delta):
	velocity = Vector2.RIGHT.rotated(rotation) * speed
	move_and_slide()
	
	var screenSize = get_viewport_rect().size
	if global_position.y < 0 or global_position.y > screenSize.y:
		queue_free()
		
		if !Global.isPowered:
			Global.points -= 50
		#print("bala fuera de límites y")
		
	if global_position.x < 0 or global_position.x > screenSize.x:
		queue_free()
		
		if !Global.isPowered:
			Global.points -= 15
		#print("bala fuera de límites x")
