extends Area2D

var movementVector := Vector2(0, -1)

var speed: int

enum AsSize{LARGE, MEDIUM, SMALL}
@export var size: AsSize

@onready var sprite = $Sprite2D

var asteroideMedio = preload("res://Prefabs/avgAs.tscn")
var asteroideChico = preload("res://Prefabs/smallAs.tscn")

func _ready() -> void:
	rotation = randf_range(0, 2*PI)
	#print(rotation_degrees)
	
	adjustSizes()

func _process(delta: float) -> void:
	global_position += movementVector.rotated(rotation) * speed * delta

func adjustSizes():
	match size:
		AsSize.LARGE:
			speed = randf_range(50, 100)
		AsSize.MEDIUM:
			speed = randf_range(101, 150)
		AsSize.SMALL:
			speed = randf_range(151, 200)

func _on_body_entered(body: Node2D) -> void:
	if size == AsSize.LARGE:
		print("mediano")
		var s = asteroideMedio.instantiate()
		get_parent().call_deferred("add_child", s)
		queue_free()
	
	elif size == AsSize.MEDIUM:
		print("chiquitungui")
		var g = asteroideChico.instantiate()
		get_parent().call_deferred("add_child", g)
		queue_free()
		
	elif size == AsSize.SMALL:
		print("naaa")
		queue_free()
