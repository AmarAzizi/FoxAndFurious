extends Control

@onready var name_input = $LineEdit
@onready var start_button = $Button

func _ready():
	start_button.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed():
	var player_name = name_input.text.strip_edges()
	if player_name != "":
		GlobalName.current_player_name = player_name
		print("Giocatore selezionato:", GlobalName.current_player_name)
		get_tree().change_scene_to_file("res://scenes/game.tscn") 
	else:
		print("Per favore, inserisci un nome valido.")
