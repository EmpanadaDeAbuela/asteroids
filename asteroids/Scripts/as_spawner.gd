extends Node2D

var asteroid = preload("res://Prefabs/asteroid.tscn")

func spawn():
	var na = asteroid.instantiate()
	na.position = position
	get_parent().call_deferred("add_child", na)
