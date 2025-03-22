extends Area2D

var movementVector := Vector2(0, -1)

var speed: int

enum AsteroidSize{LARGE, MEDIUM, SMALL}
@export var size := AsteroidSize.LARGE

@onready var sprite = $Sprite2D

func _ready() -> void:
	rotation = randf_range(0, 2*PI)
	print(rotation_degrees)
	
	match size:
		AsteroidSize.LARGE:
			speed = randf_range(50, 100)
			#sprite.texture = dpreload()
		AsteroidSize.MEDIUM:
			speed = randf_range(101, 150)
		AsteroidSize.SMALL:
			speed = randf_range(151, 200)
	print(speed)

func _process(delta: float) -> void:
	global_position += movementVector.rotated(rotation) * speed * delta
