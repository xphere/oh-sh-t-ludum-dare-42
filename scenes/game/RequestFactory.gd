extends Node

const COLORS = [
	Color(0.80, 0.00, 0.00, 1.00),
	Color(0.00, 0.80, 0.00, 1.00),
	Color(0.00, 0.00, 0.80, 1.00),
	Color(1.00, 1.00, 1.00, 1.00),
]


func create_random(balloon):
	var shape = randi() % get_child_count()
	var prototype = get_child(shape)
	var clone = prototype.duplicate()
	var color = randi() % 4
	var amount = 1 + randi() % 8
	clone.text = "%d" % amount
	clone.modulate = COLORS[color]
	clone.visible = true

	balloon.set(clone)
	balloon.set_meta("request_amount", amount)
	balloon.set_meta("request_color", color)

	return clone