extends StaticBody2D

export(int) var CELL_WIDTH = 8
export(int) var CELL_HEIGHT = 8
export(int) var WIDTH = 8
export(int) var HEIGHT = 8
export(int) var THRESHOLD = 10

var cells = {}
var total_count

signal running_out_of_space()


func _ready():
	generate_cells()


func generate_cells():
	var cell
	var Cell = preload("Cell.tscn")

	var count = 0
	for y in range(0, HEIGHT):
		for x in range(0, WIDTH):
			cell = Cell.instance()
			cell.position = Vector2(1 + CELL_WIDTH / 2 + x * CELL_WIDTH, 1 + CELL_HEIGHT / 2 + y * CELL_HEIGHT)
			cell.show_behind_parent = true
			cells[Vector2(x, y)] = cell
			add_child(cell)
			count += 1

	$Collision.position = Vector2(WIDTH * CELL_WIDTH / 2, HEIGHT * CELL_HEIGHT / 2)
	$Collision.scale = $Collision.position
	total_count = count


func check_cells(node):
	var all_correct = true
	for child in node.get_children():
		var raw_index = raw_cell_index_at(child.global_position)
		var correct = (
			clamp(raw_index.x, 0, WIDTH - 1) == raw_index.x and
			clamp(raw_index.y, 0, HEIGHT - 1) == raw_index.y and
			not cell_at(child.global_position).filled and
			true
		)
		if correct:
			child.region_rect.position.x = 0
		else:
			child.region_rect.position.x = 8
			all_correct = false

	return all_correct


func put_cells(node, color):
	for child in node.get_children():
		cell_at(child.global_position).set(color)
		total_count -= 1

	if total_count < THRESHOLD:
		emit_signal("running_out_of_space")


func raw_cell_index_at(_global_position):
	var local_pick = _global_position - global_position
	return Vector2(
		floor(local_pick.x / CELL_WIDTH),
		floor(local_pick.y / CELL_HEIGHT)
	)


func cell_index_at(_global_position):
	var raw_index = raw_cell_index_at(_global_position)
	return Vector2(
		clamp(raw_index.x, 0, WIDTH - 1),
		clamp(raw_index.y, 0, HEIGHT - 1)
	)


func cell_at(_global_position):
	return cells[cell_index_at(_global_position)]
