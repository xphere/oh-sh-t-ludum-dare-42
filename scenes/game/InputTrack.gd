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
		var balloon = create_random()
		$Tween.interpolate_property(
			balloon,
			"rect_scale",
			Vector2(0, 0),
			Vector2(1, 1),
			0.2,
			Tween.TRANS_BACK,
			Tween.EASE_OUT
		)

		balloon.modulate = Color(1.0, 1.0, 1.0, 0.0)
		$Tween.interpolate_property(
			balloon,
			"modulate",
			Color(1.0, 1.0, 1.0, 0.0),
			Color(1.0, 1.0, 1.0, 1.0),
			0.2,
			Tween.TRANS_QUAD,
			Tween.EASE_OUT
		)

		$Tween.start()


func create_random():
	var balloon = TextBalloon.instance()
	var content = $Factory.create_random(balloon)

	balloon.connect("gui_input", self, "_on_gui_input", [balloon])
	balloon.rect_scale = Vector2(0, 0)
	$List.add_child(balloon)
	emit_signal("balloon_added", balloon)

	return balloon


func _on_gui_input(event, balloon):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("balloon_clicked", balloon)
