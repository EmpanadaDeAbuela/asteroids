extends Area2D

var movementVector := Vector2(0, -1)
var speed := 200.0

@onready var colshape = $CollisionShape2D

func _ready() -> void:
	$AnimatedSprite2D.play()
	rotation = randf_range(0, 2*PI)
	$AnimatedSprite2D.rotation += 0.0001
	
func _process(delta: float) -> void:
	$AnimatedSprite2D.rotation += 0.01
	global_position += movementVector.rotated(rotation) * speed * delta
	
	var screenSize = get_viewport_rect().size
	var radius = (colshape.shape as CircleShape2D).radius * scale.x
	
	if (global_position.y+radius) < 0:
		global_position.y = (screenSize.y+radius*0.999) #andá a saber por qué si es 1 no le gusta
		#print(radius)
		
	if (global_position.y-radius) > screenSize.y:
		global_position.y = -radius
		
	if (global_position.x+radius < 0):
		global_position.x = (screenSize.x+radius*0.999)
		 
	if (global_position.x-radius) > screenSize.x:
		global_position.x = -radius


func _on_body_entered(body: Node2D) -> void:
	if body.name == "bullet":
		Global.points += 1000
	queue_free()
