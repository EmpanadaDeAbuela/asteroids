extends CharacterBody2D


@export var speed = 300.0
@export var acceleration = 40.0
@export var maxSpeed := 600.0

var bulletInst = preload("res://Prefabs/bullet.tscn")

func _ready() -> void:
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	
	# movimiento
	
	var inputVector := Vector2(Input.get_axis("move_left","move_right"), Input.get_axis("move_forward", "move_backward"))

	velocity += inputVector * acceleration
	velocity = velocity.limit_length(maxSpeed)
	
	move_and_slide()
	
	var screenSize = get_viewport_rect().size
	
	if global_position.y< 0:
		global_position.y = screenSize.y
	if global_position.y > screenSize.y:
		global_position.y = 0 
	if global_position.x < 0:
		global_position.x = screenSize.x 
	if global_position.x > screenSize.x:
		global_position.x = 0 
		
	if inputVector.y == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 3)
	if inputVector.x == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 3)

	# que mire al mouse (no puedo creer que sea una función, y yo usando unity...)
	
	look_at(get_global_mouse_position())
	
	# disparar
	
	if (Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("shoot2")) and $cooldownTimer.is_stopped():
		shoot()
		
	if Input.is_action_just_pressed("burstUp") or Input.is_action_just_pressed("burstDown"):
		
		######################################
		# PODRÍA SER UNA HABILIDAD TIPO DASH #
		######################################
		
		shoot()
		#await get_tree().create_timer(0.2s).timeout #no sé cómo apareció esto en mi código 

func shoot():
	$cooldownTimer.start()
	var bullet = bulletInst.instantiate()
	var offset = Vector2.RIGHT.rotated(rotation) * 50  # 20 píxeles adelante
	bullet.global_position = global_position + offset
	bullet.rotation = rotation
	get_parent().add_child(bullet)

#func _on_cooldown_timer_timeout() -> void:
	#print("fs") # Replace with function body.
