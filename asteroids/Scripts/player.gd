extends CharacterBody2D


@export var speed = 300.0
@export var acceleration = 40.0
@export var maxSpeed := 600.0

var powered = false
var canDie = true

var bulletInst = preload("res://Prefabs/bullet.tscn")

@onready var colshape = $CollisionShape2D

func _ready() -> void:
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	
	# movimiento
	var inputVector := Vector2(Input.get_axis("move_left","move_right"), Input.get_axis("move_forward", "move_backward"))

	velocity += inputVector * acceleration
	velocity = velocity.limit_length(maxSpeed)
	
	move_and_slide()
	
	var screenSize = get_viewport_rect().size
	var radius = (colshape.shape as CircleShape2D).radius * scale.x
	
	if (global_position.y+radius) < 0:
		global_position.y = (screenSize.y+radius*0.999) #andá a saber por qué si es 1 no le gusta
		print(radius)
		
	if (global_position.y-radius) > screenSize.y:
		global_position.y = -radius
		
	if (global_position.x+radius < 0):
		global_position.x = (screenSize.x+radius*0.999)
		 
	if (global_position.x-radius) > screenSize.x:
		global_position.x = -radius
		
	if inputVector.y == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 3)
	if inputVector.x == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 3)

	# que mire al mouse (no puedo creer que sea una función, y yo usando unity...)
	look_at(get_global_mouse_position())
	
	# disparar
	if (Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("shoot2")) and $cooldownTimer.is_stopped():
		shoot()
		
	if (Input.is_action_just_pressed("burstUp") or Input.is_action_just_pressed("burstDown")) and powered:
		shoot()
			#await get_tree().create_timer(0.2s).timeout #no sé cómo apareció esto en mi código 

func empoderar():
	Global.isPowered = true
	powered = true
	speed = 600.0
	maxSpeed = 1000.0
	$cooldownPower.start()
	#print("e")
	$AnimatedSprite2D.modulate = Color(1, 0, 0.5)

func _on_cooldown_power_timeout() -> void:
	desempoderar()

func desempoderar():
	Global.isPowered = false
	powered = false
	speed = 300.0
	maxSpeed = 600.0
	#print(powered)
	$AnimatedSprite2D.modulate = Color(1, 1, 1, 1)

func shoot():
	$cooldownTimer.start()
	var bullet = bulletInst.instantiate()
	var offset = Vector2.RIGHT.rotated(rotation) * 50  # 20 píxeles adelante
	bullet.global_position = global_position + offset
	bullet.rotation = rotation
	get_parent().add_child(bullet)

#func _on_cooldown_timer_timeout() -> void:
	#print("fs") # Replace with function body.
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "asteroid": #intenté que si te "mata" un asteroide no mueras, sino que solo te saque el efecto powered
		#print(canDie)
		if powered and canDie:
			desempoderar()
			canDie = false
			print(canDie)
			#await get_tree().create_timer(1.0).timeout
			canDie = true
			print(canDie)
		else:
			queue_free()
	elif area.name == "asteroidEstatua":
		$"../VBoxContainer/Label4".text = "Los humanos son curiosos..."
		queue_free()
	else:
		empoderar()
		#print("power")
