extends VBoxContainer

const MAX_ALLOWED = 6

signal balloon_clicked(balloon)

onready var factory = preload("res://scenes/game/PieceFactory.tscn").instance()
onready var TextBalloon = preload("res://scenes/gui/TextBalloon.tscn")


func _ready():
	randomize()
	for index in range(0, MAX_ALLOWED):
		new_random_input()


func new_random_input():
	if get_child_count() >= MAX_ALLOWED:
		return false

	var balloon = TextBalloon.instance()
	var input = factory.random()
	balloon.set(input)
	balloon.set_meta("piece_index", input.get_meta("piece_index"))
	balloon.set_meta("piece_color", input.get_meta("piece_color"))
	balloon.connect("gui_input", self, "gui_input", [balloon])
	add_child(balloon)
	return true


func gui_input(event, balloon):
	if not event is InputEventMouseButton:
		return

	if event.button_index != BUTTON_LEFT:
		return

	if event.is_pressed():
		emit_signal("balloon_clicked", balloon)
