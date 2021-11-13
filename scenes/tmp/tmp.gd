extends Node2D

onready var club10 = $Club10
onready var diamond10 = $Diamond10


func _ready():
	pass


func _on_flip_button_pressed():
	club10.flip()


func _on_diamond10_pressed():
	diamond10.flip()

