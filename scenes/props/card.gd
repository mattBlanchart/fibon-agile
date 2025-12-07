extends Control

@export var value: int = 0

# Appeler cette méthode pour initialiser les variables de l'unité après création
func initialize(value: int ):
	$".".value = value
	$Control/ContentMargin/Label.text = str(value)
