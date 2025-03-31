extends Area2D

var movementVector := Vector2(0, -1)
var speed: int
#var angle:= 0.0
@export var size: int

var nuevoAs = preload("res://Prefabs/asteroid.tscn")

func _ready() -> void:
	rotation = randf_range(0, 2*PI)
	adjustSizes()
	#adjustRotation() #anda raro, sería más claro si supiera llamar a una función luego de instanciar el nuevo asteroide
	#print(angle)
	#print(rotation)

func _process(delta: float) -> void:
	global_position += movementVector.rotated(rotation) * speed * delta
	
	var screenSize = get_viewport_rect().size*1.5 #para que no parezca que los grandes desaparecen
	
	if global_position.y < 0 or global_position.y > screenSize.y*1.5:
		queue_free()
		print("asteroide fuera")
		
	if global_position.x < 0 or global_position.x > screenSize.x*1.5:
		queue_free()

func adjustSizes():
	match size:
		2:
			speed = randf_range(50, 100)
			$".".scale = Vector2(1, 1)
		1:
			speed = randf_range(100, 500)
			$".".scale = Vector2(0.5, 0.5)
		0:
			speed = randf_range(500, 1000)
			$".".scale = Vector2(0.2, 0.2)
	#print(speed)

#func adjustRotation():
#	var offset = 15 # Variación aleatoria entre -15° y 15°
#	
#	if size != 2:
#		angle += deg_to_rad(randf_range(-offset, offset))
#		rotation = angle
#	else:
#		rotation = randf_range(0, 2*PI)

func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "player":
		body.queue_free()
		return
	
	Global.points += 1
	
	#var direction = ($"../player".global_position - global_position).normalized()
	#angle = rad_to_deg(direction.angle())
	#print("ángulo al explotar: " + str(angle))
	
	if size == 2:
		#print("mediano")
		
		instanciateAs(1)
		instanciateAs(1)
		queue_free()
	
	elif size == 1:
		#print("chiquitungui")
		
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
	#na.angle = angle
	get_parent().call_deferred("add_child", na)
