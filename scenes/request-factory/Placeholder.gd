extends Position2D


func check_into(grid, position):
	var color = grid.bit_color(position)
	var bits = grid.adjacents(position)

	var result = color == get_meta("color") and bits.size() == get_meta("amount")

	if result:
		grid.select(bits)
	else:
		grid.unselect_all()

	return result


func apply_to(grid, position):
	var bits = grid.adjacents(position)
	for bit in bits:
		grid.remove(bit)
	grid.unselect_all()


func rotate():
	pass


func reset():
	pass
