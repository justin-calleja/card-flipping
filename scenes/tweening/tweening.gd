extends Node2D

const Card = preload("res://scenes/card/card.tscn")
const BackTexture = preload("res://assets/back.png")
const FrontTexture = preload("res://assets/10_diamond.png")

onready var deck = $Deck
onready var deal_btn = $Button
onready var deal_pos = $DealPosition
onready var tween: CardTween = $CardTween

export var x_offset: int = 200

var is_glow_high = false
var selected_card: Card = null


func _input(event):
	if selected_card == null:
		return

	if event.is_action_pressed("ui_right"):
		select_card_by_index((selected_card.get_index() + 1) % get_card_count())
	elif event.is_action_pressed("ui_left"):
		var last_card_index = get_card_count() - 1
		var selected_card_index = selected_card.get_index()
		select_card_by_index(
			last_card_index if selected_card_index <= 0 else selected_card_index - 1
		)
	elif event.is_action_pressed("ui_select"):
		selected_card.flip()


func add_card_to_tree(card: Card) -> void:
	deal_pos.add_child(card)
	card.rect_global_position = deck.rect_global_position


func get_card_count() -> int:
	return deal_pos.get_child_count()


func get_card_by_index(index: int) -> Card:
	return deal_pos.get_child(index)


func new_card() -> Card:
	var card = Card.instance()
	card.back_texture = BackTexture
	card.front_texture = FrontTexture
	return card


func deal_cards(num_to_deal: int):
	if num_to_deal <= 0:
		select_card_by_index(0)
		return

	var card = new_card()
	add_card_to_tree(card)
	var num_of_cards = get_card_count()
	# assert(card.rect_global_position == deck.rect_global_position)
	tween.move(
		card,
		card.rect_global_position,
		deal_pos.global_position + Vector2(x_offset * num_of_cards, 0)
	)
	yield(tween, "tween_all_completed")
	deal_cards(num_to_deal - 1)


func select_card_by_index(index: int):
	var prev_selected_card = selected_card
	selected_card = get_card_by_index(index)

	if selected_card == null:
		selected_card = prev_selected_card
		return

	if selected_card == prev_selected_card:
		return

	if prev_selected_card != null:
		tween.glow_off(prev_selected_card)

	start_glow_card(selected_card)


func start_glow_card(card: Card):
	is_glow_high = true
	tween.glow_high(card)


func glow_card(card: Card):
	if is_glow_high:
		tween.glow_low(card)
	else:
		tween.glow_high(card)
	is_glow_high = !is_glow_high


func _on_deal_pressed():
	deal_btn.disabled = true
	deal_cards(3)


func _on_tween_completed(obj: Object, key: NodePath):
	if key == ":modulate" and obj == selected_card:
		glow_card(selected_card)
