extends Node2D


func _ready():
	$Diamond10/Button.connect('pressed', self, '_on_diamond10_pressed')
	

func _on_flip_button_pressed():
	$Club10.flip()


func _on_diamond10_pressed():
	$Diamond10.flip()
