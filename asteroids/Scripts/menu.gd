extends Control

func _process(delta: float) -> void:
	$HBoxContainer/record.text = "Record: " + str(Global.record)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn") # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit() # Replace with function body.

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/settings_menu.tscn")

func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/tutorial_menu.tscn")
