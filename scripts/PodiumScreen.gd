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
	# 1. Filtra per tenere solo il punteggio più alto per ogni nome
	var best_scores = {}
	for entry in GlobalName.players_data:
		var name = entry["name"]
		var score = entry["score"]
		if not best_scores.has(name) or score > best_scores[name]:
			best_scores[name] = score

	# 2. Crea una lista dagli elementi filtrati
	var sorted = []
	for name in best_scores.keys():
		sorted.append({"name": name, "score": best_scores[name]})

	# 3. Ordina la lista dal punteggio più alto al più basso
	sorted.sort_custom(func(a, b):
		return a["score"] > b["score"]
	)

	# 4. Riempi le prime 5 righe
	for i in range(data_labels.size()):
		if i < sorted.size():
			var entry = sorted[i]
			data_labels[i].text = "%d. %s — %d" % [i+1, entry["name"], entry["score"]]
		else:
			data_labels[i].text = "%d. —" % (i+1)
