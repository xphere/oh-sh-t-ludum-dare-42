extends Node

const COLORS = [
	Color(0.80, 0.00, 0.00, 1.00),
	Color(0.00, 0.80, 0.00, 1.00),
	Color(0.00, 0.00, 0.80, 1.00),
]


func random():
	var index = randi() % get_child_count()
	var prototype = get_child(index)
	var clone = prototype.duplicate()
	var color = randi() % 3
	clone.modulate = COLORS[color]
	clone.set_meta("piece_index", index)
	clone.set_meta("piece_color", color)
	clone.visible = true

	return clone
