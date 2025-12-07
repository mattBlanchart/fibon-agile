extends Control

# Voir si on conserve juste les nombres associés à l'unité 
# et on instancie les cartes dans la scène de battleground
# OU si on lui associe une liste de scène de cartes
@export var cards: Array = Array()
@export var passif: String = ""
var card_scene = preload("res://scenes/cardui/Card.tscn")

# Appeler cette méthode pour initialiser les variables de l'unité après création
func initialize(numbers: Array, pouvoir: String):
	for i in numbers :
		#i est le numéro à afficher sur la carte, ptet c'est Data en fait, faut que je vois avec Raphh
		var card = card_scene.instantiate(i)
		print(card)
		cards.append(card)	
	passif = pouvoir
