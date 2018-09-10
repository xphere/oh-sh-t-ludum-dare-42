extends Position2D


func check_into(grid, position):
	var color = grid.bit_color(position)
	var bits = grid.adjacents(position)

	return color == get_meta("color") and bits.size() == get_meta("amount")


func apply_to(grid, position):
	var bits = grid.adjacents(position)
	for bit in bits:
		grid.remove(bit)


func rotate():
	pass


func reset():
	pass
