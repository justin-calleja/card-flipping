extends TextureRect

onready var ap: AnimationPlayer = $AnimationPlayer

var is_face_up = false
export var front_texture: Texture
export var back_texture: Texture


# Called when the node enters the scene tree for the first time.
func _ready():
	set_texture()


func set_texture(a_texture = null):
	if a_texture == null:
		texture = front_texture if is_face_up else back_texture
	else:
		texture = a_texture


func flip_texture():
	is_face_up = !is_face_up
	set_texture()
	

func flip():
	ap.play("flip")


func _on_Button_pressed():
	flip()
