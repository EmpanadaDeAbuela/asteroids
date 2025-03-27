extends Area2D

var movementVector := Vector2(0, -1)

var speed: int

enum AsSize{LARGE, MEDIUM, SMALL}
@export var size := AsSize.LARGE

@onready var sprite = $Sprite2D

func _ready() -> void:
	rotation = randf_range(0, 2*PI)
	print(rotation_degrees)
	
	adjustSizes()
	

func _process(delta: float) -> void:
	global_position += movementVector.rotated(rotation) * speed * delta
	
func adjustSizes():
	match size:
		AsSize.LARGE:
			speed = randf_range(50, 100)
			#sprite.texture = dpreload()
		AsSize.MEDIUM:
			speed = randf_range(101, 150)
		AsSize.SMALL:
			speed = randf_range(151, 200)
	print(speed)
	
