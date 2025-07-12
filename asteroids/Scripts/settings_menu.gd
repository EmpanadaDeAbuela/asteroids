extends Control

func _ready() -> void:
	setValues()

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value / 10.0))
	Global.musicValue = value


func setValues():
	$VBoxContainer/MusicSlider.value = Global.musicValue
	$VBoxContainer/SFXSlider.value = Global.sfxValue
	
	if Global.bulletsThroughWalls:
		$VBoxContainer/lasersThroughWalls.text = "on"
		showFF()
	else:
		$VBoxContainer/lasersThroughWalls.text = "off"
		hideFF()
		
	
	if Global.friendlyFire:
		$VBoxContainer/friendlyFire2.text = "on"
	else: 
		$VBoxContainer/friendlyFire2.text = "off"

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value / 10.0))
	Global.sfxValue = value


func _on_lasers_through_walls_pressed() -> void:
	Global.bulletsThroughWalls = !Global.bulletsThroughWalls
	Global.friendlyFire = !Global.friendlyFire
	setValues()


func _on_friendly_fire_2_pressed() -> void:
	Global.friendlyFire = !Global.friendlyFire
	setValues()

func hideFF():
	$VBoxContainer/friendlyFire.visible = false
	$VBoxContainer/friendlyFire2.visible = false

func showFF():
	$VBoxContainer/friendlyFire.visible = true
	$VBoxContainer/friendlyFire2.visible = true
