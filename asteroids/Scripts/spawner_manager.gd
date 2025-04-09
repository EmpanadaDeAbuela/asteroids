extends Node2D

var awaitTime = 5


func _ready() -> void:
	$spawnTimer.wait_time = awaitTime
	
func _process(delta: float) -> void:
	
	
	if $spawnTimer.is_stopped(): #if Input.is_action_just_pressed("special"):
		
		var num = randi() % 8 + 1
		match num:
			1:
				$asSpawner1.spawn()
				#print("Salió 1")
			2:
				$asSpawner2.spawn()
				#print("Salió 2")
			3:
				$asSpawner3.spawn()
				#print("Salió 3")
			4:
				$asSpawner4.spawn()
				#print("Salió 4")
			5:
				$asSpawner5.spawn()
				#print("Salió 5")
			6:
				$asSpawner6.spawn()
				#print("Salió 6")
			7:
				$asSpawner7.spawn()
				#print("Salió 7")
			8:
				$asSpawner8.spawn()
				#print("Salió 8")
				
		$spawnTimer.start()
