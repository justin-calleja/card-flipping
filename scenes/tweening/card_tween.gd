extends Tween
class_name CardTween

export var glow_high_color = Color(1.2, 1.2, 1.2, 1)
export var glow_low_color = Color(1.1, 1.1, 1.1, 1)
export var glow_off_color = Color(1, 1, 1, 1)
export var glow_duration = 0.4


func move(
	card: TextureRect, initial_position: Vector2, target_position: Vector2, duration: float = 0.5
) -> void:
	interpolate_property(
		card,
		"rect_global_position",
		initial_position,
		target_position,
		duration,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT
	)
	start()


func glow_high(card: TextureRect, duration: float = glow_duration) -> void:
	glow(card, card.modulate, glow_high_color, duration)


func glow_low(card: TextureRect, duration: float = glow_duration) -> void:
	glow(card, card.modulate, glow_low_color, duration)


func glow_off(card: TextureRect) -> void:
	remove(card)
	card.modulate = glow_off_color


func glow(card: TextureRect, start_color: Color, end_color: Color, duration: float = glow_duration) -> void:
	interpolate_property(
		card, "modulate", start_color, end_color, duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	start()
