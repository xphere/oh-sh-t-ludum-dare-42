extends Node2D

func create(index, color):
	var clone = get_child(index).duplicate()

	clone.visible = true
	clone.set_meta("bit_index", index)
	clone.set_meta("bit_color", color)
	for child in clone.get_children():
		child.region_rect.position.y = color * 7

	return clone
