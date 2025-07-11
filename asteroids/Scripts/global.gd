extends Node

var points = 0
var record = 0

var isPowered = false

var musicValue = 10
var sfxValue = 10

#game mode settings
var english = true
var bulletsThroughWalls = false
var friendlyFire = true

# asteroide grande eliminado	= +10 puntos
# asteroide mediano eliminado	= +25 puntos
# asteroide chico eliminado 	= +50 puntos
# bala perdida 					= -35 puntos
# destruír powerUp				= +100 puntos
# sobrevivir un segundo 		= +1 puntos

#@onready var fadeRect = $fadeRect

func _ready():
	pass#print("fadeRect:", fadeRect)

func _process(delta: float) -> void:
	if points >= record:
		record = points

#func fadeAndChange(new_scene_path: String) -> void:
#	fadeRect.visible = true
#	fadeRect.modulate.a = 0.0

#	var tween = create_tween()
#	tween.tween_property(fadeRect, "modulate:a", 1.0, 1.0) 

#	await tween.finished

#	get_tree().change_scene_to_file(new_scene_path)

#	await get_tree().create_timer(0.1).timeout
#	fadeRect.modulate.a = 1.0

#	var tween_out = create_tween()
#	tween_out.tween_property(fadeRect, "modulate:a", 0.0, 1.0) 
