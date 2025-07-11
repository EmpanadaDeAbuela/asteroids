extends CharacterBody2D

@export var speed: float = 1000.0

var la = preload("res://Audio/sfx/la.mp3")
var si = preload("res://Audio/sfx/si.mp3")
var do = preload("res://Audio/sfx/do.mp3")
var re = preload("res://Audio/sfx/re.mp3")
var mi = preload("res://Audio/sfx/mi.mp3")
var mi0 = preload("res://Audio/sfx/mi0.mp3")
var fa0 = preload("res://Audio/sfx/fa0.mp3")
var sol0 = preload("res://Audio/sfx/sol0.mp3")

@onready var bulletSize = $CollisionShape2D.shape
@onready var ancho = bulletSize.extents.x * 2

func _ready() -> void:
	
	#print(Global.isPowered)

	if Global.isPowered:
		var nota = randi_range(1, 4)
		
		match nota:
			1:
				$AudioStreamPlayer.stream = fa0
			2:
				$AudioStreamPlayer.stream = la
			3:
				$AudioStreamPlayer.stream = do
			4:
				$AudioStreamPlayer.stream = mi
				
	else:
		var nota = randi_range(1, 8)
		
		match nota:
			1:
				$AudioStreamPlayer.stream = la
			2:
				$AudioStreamPlayer.stream = si
			3:
				$AudioStreamPlayer.stream = do
			4:
				$AudioStreamPlayer.stream = re
			5:
				$AudioStreamPlayer.stream = mi
			6:
				$AudioStreamPlayer.stream = fa0
			7:
				$AudioStreamPlayer.stream = sol0
			8:
				$AudioStreamPlayer.stream = mi0
	$AudioStreamPlayer.play()

func _physics_process(delta):
	
	var screenSize = get_viewport_rect().size
	
	if (global_position.y + ancho < 0) and Global.bulletsThroughWalls:
		global_position.y = (screenSize.y)
		#print(radius)
		
	if (global_position.y - ancho > screenSize.y) and Global.bulletsThroughWalls:
		global_position.y = -ancho
		
	if (global_position.x + ancho < 0) and Global.bulletsThroughWalls:
		global_position.x = (screenSize.x)
		 
	if (global_position.x - ancho > screenSize.x) and Global.bulletsThroughWalls:
		global_position.x = -ancho
	
	velocity = Vector2.RIGHT.rotated(rotation) * speed
	move_and_slide()
	
	if !Global.bulletsThroughWalls:
		if global_position.y < 0 or global_position.y > screenSize.y:
			queue_free()
			
			if !Global.isPowered:
				Global.points -= 50
			#print("bala fuera de límites y")
			
		if global_position.x < 0 or global_position.x > screenSize.x:
			queue_free()
			
			if !Global.isPowered:
				Global.points -= 15
			#print("bala fuera de límites x")
