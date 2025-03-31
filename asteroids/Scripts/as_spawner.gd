extends Node2D

var asteroid = preload("res://Prefabs/asteroid.tscn")
var awaitTime = 5

func _ready() -> void:
	$spawnTimer.wait_time = awaitTime

func _process(delta: float) -> void:
	
	if $spawnTimer.is_stopped(): #if Input.is_action_just_pressed("special"):
		$spawnTimer.start()
		
		var na = asteroid.instantiate()
		na.position = position
		get_parent().call_deferred("add_child", na)
	
	
	#$spawnTimer.wait_time -= 0.01
	#print($spawnTimer.wait_time)
