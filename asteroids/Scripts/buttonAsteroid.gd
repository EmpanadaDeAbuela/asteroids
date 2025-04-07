extends Control

var movementVector := Vector2(0, -1)
var speed: int

@onready var colshape = $CollisionShape2D

func _ready() -> void:
	rotation = randf_range(0, 2*PI)


func _process(delta: float) -> void:
	global_position += movementVector.rotated(rotation) * speed * delta
	
	var screenSize = get_viewport_rect().size
	#print(radius)
	
	if (global_position.y) < 0:
		global_position.y = (screenSize.y) #andá a saber por qué si es 1 no le gusta
		#print(radius)
		
	if (global_position.y) > screenSize.y:
		global_position.y = 0
		
	if (global_position.x < 0):
		global_position.x = (screenSize.x)
		 
	if (global_position.x) > screenSize.x:
		global_position.x = 0
