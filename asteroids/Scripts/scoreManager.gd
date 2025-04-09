extends Node2D

var tiempo_pasado := 0.0
var tiempo_acumulado := 0.0

func _process(delta: float) -> void:
	$Label.text = str(Global.points)
	
	tiempo_acumulado += delta
	
	if tiempo_acumulado >= 1.0:
		tiempo_acumulado -= 1.0 
		sobrevivir()
		
		
	if $player == null:
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
		Global.points = 0

func sobrevivir():
	Global.points += 1
	
