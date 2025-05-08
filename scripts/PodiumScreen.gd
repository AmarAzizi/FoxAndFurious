extends Control

@onready var replay_button = $Rigioca
@onready var exit_button = $Esci  

# Riferimenti alle Label per riempirle dinamicamente
@onready var data_labels := [
	$VBoxContainer/Row1/DataLabel1,
	$VBoxContainer/Row2/DataLabel2,
	$VBoxContainer/Row3/DataLabel3,
	$VBoxContainer/Row4/DataLabel4,
	$VBoxContainer/Row5/DataLabel5,
]

func _ready():
	replay_button.pressed.connect(_on_replay_button_pressed)  # Collegamento del bottone "Rigioca"
	exit_button.pressed.connect(_on_exit_button_pressed)      # Collegamento del bottone "Esci"
	_update_podium()

# Funzione che ricarica la scena per rigiocare
func _on_replay_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn") # Ricarica la scena attuale per ricominciare il gioco

# Funzione che chiude il gioco
func _on_exit_button_pressed():
	get_tree().quit()  # Chiude l'applicazione

func _update_podium():
	# Prendi i dati e ordina per punteggio decrescente
	var sorted = GlobalName.players_data.duplicate()
	sorted.sort_custom(func(a, b):
		return b["score"] - a["score"]
	)
	# Riempi le prime 5 righe
	for i in range(data_labels.size()):
		if i < sorted.size():
			var entry = sorted[i]
			data_labels[i].text = "%s — %d" % [entry["name"], entry["score"]]
		else:
			# Se non c'è abbastanza dati, mostra placeholder
			data_labels[i].text = "%d. —" % (i+1)
