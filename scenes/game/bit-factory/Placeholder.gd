extends Position2D


func check_into(grid, position):
	reset()

	var result = true
	for child in get_children():
		var local_position = position + grid.from_relative(child.offset)
		if not grid.is_free(local_position):
			result = false
			child.region_rect.position = Vector2(57, 41)

	return result


func apply_to(grid, position):
	for child in get_children():
		var local_position = position + grid.from_relative(child.offset)
		var bit = child.duplicate()
		bit.offset = Vector2()
		grid.fill(local_position, bit)


func reset():
	for bit in get_children():
		bit.region_rect.position = Vector2(1, 1)
