extends Control

@onready var tutorial1 = $VBoxContainer/VBoxContainer/Label
@onready var tutorial2 = $VBoxContainer/VBoxContainer/Label2
@onready var tutorial3 = $VBoxContainer/VBoxContainer/Label3

@onready var tutorial4 = $VBoxContainer/Label3
@onready var tutorial5 = $VBoxContainer/Label4
@onready var tutorial6 = $Label4

@onready var translater = $translate

func _ready() -> void:
	
	match Global.english:
		true:
			setEnglishText()
		false:
			setSpanishText()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_translate_pressed() -> void:
	Global.english = !Global.english
	if Global.english:
		setEnglishText()
	else:
		setSpanishText()



func setSpanishText():
	translater.text = " english"
	tutorial1.text = "Tu objetivo es hacer la mayor cantidad de puntos."
	tutorial2.text = "Los puntos se suman al destruír asteroides y consumir objetos, pero se pierden al errar balas."
	tutorial3.text = "
+1 punto / segundo vivo
 
asteroide grande eliminado = +10 puntos
asteroide mediano eliminado = +25 puntos
asteroide chico eliminado = +50 puntos

bala perdida = -35 puntos

destruír power up = +1000 puntos"
	tutorial4.text = "Te movés con WASD y apuntás con el mouse."
	tutorial5.text = "Si chocás con un asteroide perdés. (No lo hagas)"
	tutorial6.text = "




Se dispara con click izquierdo
Se usa la ametralladora con la rueda del mouse
pero sólo si primero se consume un power up"

func setEnglishText():
	translater.text = " español"
	tutorial1.text = "Your goal is to score as many points as possible."
	tutorial2.text = "Points are earned by destroying asteroids and collecting items, but lost by missing shots."
	tutorial3.text = "
+1 point / second alive
 
large asteroid destroyed = +10 points
medium asteroid destroyed = +25 points
small asteroid destroyed = +50 points

missed shot = -35 points

destroying power up = +1000 points"
	tutorial4.text = "Move with WASD and aim with the mouse."
	tutorial5.text = "If you crash into an asteroid, you lose. (Don’t do it)"
	tutorial6.text = "




Shoot with left click
Use the machine gun with the mouse wheel
but only after picking up a power up"
