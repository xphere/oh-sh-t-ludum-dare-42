extends Position2D


var placeholder


func set_placeholder(placeholder):
	reset()
	self.placeholder = placeholder
	add_child(placeholder)


func reset():
	rotation_degrees = 0
	placeholder.queue_free() if placeholder else 0
	placeholder = null


func rotate():
	rotation_degrees += 90
	for child in placeholder.get_children() if placeholder else []:
		child.rotation_degrees -= 90


func reset_correctness():
	for child in placeholder.get_children() if placeholder else []:
		child.region_rect.position.x = 0


func check_grid(grid):
	return grid.check_cells(placeholder) if placeholder else false


func check_requirements(grid, amount, color):
	var adjacents = grid.adjacents(global_position) if placeholder else []

	return adjacents.size() == amount and (color == 3 or adjacents[0].color == color)


func remove_adjacents(grid):
	var adjacents = grid.adjacents(global_position) if placeholder else []

	for cell in adjacents:
		cell.unset()

	grid.refresh_cells()


func put_cells(grid, color):
	grid.put_cells(placeholder, color)
