extends Control

@onready var name_input = $LineEdit
@onready var start_button = $Button

func _ready():
	# -> Metodo più “Godot 4 style”
	start_button.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed():
	var player_name = name_input.text.strip_edges()
	if player_name != "":
		print("Nome del giocatore:", player_name)
		get_tree().change_scene("res://scenes/node.tscn")
	else:
		print("Per favore, inserisci un nome valido.")
