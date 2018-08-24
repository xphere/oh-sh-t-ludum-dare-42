extends Container

export(int) var MAX_ALLOWED = 6

signal balloon_added(balloon)
signal balloon_clicked(balloon)

onready var TextBalloon = preload("res://scenes/gui/TextBalloon.tscn")


func _ready():
	randomize()
	for index in range(0, MAX_ALLOWED):
		create_random()


func tick():
	if $List.get_child_count() < MAX_ALLOWED:
		create_random()


func create_random():
	var balloon = TextBalloon.instance()
	var content = $Factory.create_random(balloon)

	balloon.connect("gui_input", self, "_on_gui_input", [balloon])
	$List.add_child(balloon)
	emit_signal("balloon_added", balloon)


func _on_gui_input(event, balloon):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("balloon_clicked", balloon)
