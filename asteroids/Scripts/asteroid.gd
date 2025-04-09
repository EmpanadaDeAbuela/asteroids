extends Area2D

var movementVector := Vector2(0, -1)
var speed: int
#var angle:= 0.0
@export var size: int

@onready var colshape = $CollisionShape2D
@onready var sprite = $Sprite2D

var nuevoAs = preload("res://Prefabs/asteroid.tscn")
var powerUp = preload("res://Prefabs/powerUp.tscn")

func _ready() -> void:
	$AnimatedSprite2D.play()
	rotation = randf_range(0, 2*PI)
	adjustSizes()
	#adjustRotation() #anda raro, sería más claro si supiera llamar a una función luego de instanciar el nuevo asteroide
	#print(angle)
	#print(rotation)

func _process(delta: float) -> void:
	if size == 2:
		$AnimatedSprite2D.rotation += 0.0005
	elif size == 1:
		$AnimatedSprite2D.rotation += 0.001
	elif size == 0:
		$AnimatedSprite2D.rotation += 0.01
		
	global_position += movementVector.rotated(rotation) * speed * delta
	
	var screenSize = get_viewport_rect().size
	var radius = (colshape.shape as CircleShape2D).radius * scale.x
	#print(radius)
	
	if (global_position.y+radius) < 0:
		global_position.y = (screenSize.y+radius*0.999) #andá a saber por qué si es 1 no le gusta
		#print(radius)
		
	if (global_position.y-radius) > screenSize.y:
		global_position.y = -radius
		
	if (global_position.x+radius < 0):
		global_position.x = (screenSize.x+radius*0.999)
		 
	if (global_position.x-radius) > screenSize.x:
		global_position.x = -radius
	
	#if global_position.y < -100 or global_position.y > screenSize.y*1.5:
	#	queue_free()
	#	print("asteroide fuera")
	#	
	#if global_position.x < 0 or global_position.x > screenSize.x*1.5:
	#	queue_free()

func adjustSizes():
	match size:
		2:
			speed = randf_range(50, 100)
			$".".scale = Vector2(1, 1)
			#sprite.texture = preload()
		1:
			speed = randf_range(100, 250)
			$".".scale = Vector2(0.5, 0.5)
		0:
			speed = randf_range(250, 500)
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
	
	#var direction = ($"../player".global_position - global_position).normalized()
	#angle = rad_to_deg(direction.angle())
	#print("ángulo al explotar: " + str(angle))
		
	if size == 2:
		#print("mediano")
		
		instanciateAs(1)
		instanciateAs(1)
		destruir()
		
		if !body.name == "player":
			Global.points += 10
		
		if randi() % 15 == 0:
			instanciatePowerUp()
	
	elif size == 1:
		#print("chiquitungui")
		
		instanciateAs(0)
		instanciateAs(0)
		destruir()
		
		if !body.name == "player":
			Global.points += 25
		
		if randi() % 15 == 0:
			instanciatePowerUp()
		
	elif size == 0:
		#print("naaa")
		destruir()
		
		if !body.name == "player":
			Global.points += 50
	
	body.queue_free()

func instanciateAs(newSize: int):
	var na = nuevoAs.instantiate()
	na.size = newSize
	na.position = position
	#na.angle = angle
	get_parent().call_deferred("add_child", na)
	
func instanciatePowerUp():
	var pu = powerUp.instantiate()
	pu.position = position
	get_parent().call_deferred("add_child", pu)

func destruir():
	get_parent().get_parent().asteroideEliminado()
	queue_free()
