extends Area2D

var movementVector := Vector2(0, -1)

var speed: int

@export var size: int

var nuevoAs = preload("res://Prefabs/asteroid.tscn")

func _ready() -> void:
	adjustSizes()
	rotation = randf_range(0, 2*PI)
	#print(rotation_degrees)

func _process(delta: float) -> void:
	global_position += movementVector.rotated(rotation) * speed * delta
	
	var screenSize = get_viewport_rect().size*1.5 #para que no parezca que los grandes desaparecen
	
	if global_position.y < 0 or global_position.y > screenSize.y:
		queue_free()
		#print("bala fuera de límites y")
		
	if global_position.x < 0 or global_position.x > screenSize.x:
		queue_free()

func adjustSizes():
	match size:
		2:
			speed = randf_range(50, 100)
			$".".scale = Vector2(1, 1)
		1:
			speed = randf_range(101, 150)
			$".".scale = Vector2(0.5, 0.5)
		0:
			speed = randf_range(151, 200)
			$".".scale = Vector2(0.2, 0.2)
	print(speed)

func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "player":
		body.queue_free()
		return
	
	if size == 2:
		#print("mediano")
		
		instanciateAs(1)
		instanciateAs(1)
		queue_free()
	
	elif size == 1:
		print("chiquitungui")
		
		instanciateAs(0)
		instanciateAs(0)
		queue_free()
		
	elif size == 0:
		#print("naaa")
		queue_free()
	
	body.queue_free()

func instanciateAs(newSize: int):
	var na = nuevoAs.instantiate()
	na.size = newSize
	na.position = position
	get_parent().call_deferred("add_child", na)
