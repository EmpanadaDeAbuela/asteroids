extends Node

var points = 0
var record = 0

var isPowered = false

var musicValue = 10
var sfxValue = 10

# asteroide grande eliminado	= +10 puntos
# asteroide mediano eliminado	= +25 puntos
# asteroide chico eliminado 	= +50 puntos
# bala perdida 					= -15 puntos
# destruír powerUp				= +100 puntos
# sobrevivir un segundo 		= +1 puntos

func _process(delta: float) -> void:
	if points >= record:
		record = points
