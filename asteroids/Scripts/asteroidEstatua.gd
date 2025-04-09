extends Area2D

func _ready() -> void:
	$AnimatedSprite2D.play()
	
func _process(delta: float) -> void:
	rotation += 0.001
