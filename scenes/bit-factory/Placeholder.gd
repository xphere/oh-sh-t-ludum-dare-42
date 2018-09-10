extends Position2D


func check_into(grid, position):
	reset()

	var result = true
	for child in get_children():
		var local_position = grid.to_local(child.global_position)
		if local_position == null or not grid.is_free(local_position):
			result = false
			child.region_rect.position = Vector2(56, 40)

	return result


func apply_to(grid, position):
	for child in get_children():
		var local_position = grid.to_local(child.global_position)
		var bit = child.duplicate()
		bit.rotation = 0.0
		grid.fill(local_position, bit)


func rotate():
	rotation_degrees += 90.0
	for child in get_children():
		child.rotation_degrees += 270.0


func reset():
	for bit in get_children():
		bit.region_rect.position = Vector2(0, 0)
