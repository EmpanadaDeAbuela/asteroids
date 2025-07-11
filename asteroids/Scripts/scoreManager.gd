extends Node2D

var tiempo_pasado := 0.0
var tiempo_acumulado := 0.0

var asExplosion = preload("res://Audio/sfx/asExplosion.mp3")
var puExplosion = preload("res://Audio/sfx/puExplosion.mp3")

func _ready() -> void:
	Global.points = 0

func _process(delta: float) -> void:
	$Label.text = str(Global.points)
	
	tiempo_acumulado += delta
	
	if tiempo_acumulado >= 1.0:
		tiempo_acumulado -= 1.0 
		sobrevivir()
		
	if $player == null:
		await get_tree().create_timer(3.0).timeout
		#Global.fadeAndChange("res://Scenes/menu.tscn")
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
		Global.points = 0
	
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
		Global.points = 0

func sobrevivir():
	Global.points += 1

func asteroideEliminado():
	$AudioStreamPlayer.stream = asExplosion
	$AudioStreamPlayer.play()
	
func powerUpEliminado():
	$AudioStreamPlayer.stream = puExplosion
	$AudioStreamPlayer.play()
