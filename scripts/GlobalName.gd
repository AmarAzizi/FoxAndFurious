extends Node

var players_data = []  # Qui si salvano tutti i nomi e punteggi
var current_player_name = ""  # Questo viene impostato quando il player scrive il nome

const SAVE_FILE_PATH = "user://players.save"  # Percorso del file

func _ready():
	load_players()  # Carica i dati salvati all'inizio del gioco
	print("Tutti i dati salvati:", players_data)

func add_player(name: String, score: int):
	players_data.append({"name": name, "score": score})
	save_players()  # Ogni volta che aggiungi, salvi su disco

func save_players():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	var data_to_save = players_data
	file.store_string(JSON.stringify(data_to_save))
	file.close()
	print("Dati salvati!")

func load_players():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		players_data = JSON.parse_string(content)
		file.close()
		print("Dati caricati!")
	else:
		print("Nessun file di salvataggio trovato.")
