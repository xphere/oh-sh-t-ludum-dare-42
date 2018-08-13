extends Node


func random():
	var index = randi() % get_child_count()
	var prototype = get_child(index)
	var clone = prototype.duplicate()
	clone.visible = true
	var color = randi() % 3
	match color:
		0: clone.modulate = Color(0.80, 0.00, 0.00, 1.00)
		1: clone.modulate = Color(0.00, 0.80, 0.00, 1.00)
		2: clone.modulate = Color(0.00, 0.00, 0.80, 1.00)
	clone.set_meta("piece_index", index)
	clone.set_meta("piece_color", color)
	return clone
