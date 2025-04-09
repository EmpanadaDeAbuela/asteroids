extends Control

func _ready() -> void:
	setValues()

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value / 10.0))
	Global.musicValue = value



func setValues():
	$VBoxContainer/MusicSlider.value = Global.musicValue
	$VBoxContainer/SFXSlider.value = Global.sfxValue



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value / 10.0))
	Global.sfxValue = value
