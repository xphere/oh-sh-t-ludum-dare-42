extends StaticBody2D

export(int) var CELL_WIDTH = 8
export(int) var CELL_HEIGHT = 8
export(int) var WIDTH = 8
export(int) var HEIGHT = 8

var cells = {}


func _ready():
	generate_cells()


func generate_cells():
	var cell
	var Cell = preload("Cell.tscn")

	for y in range(0, HEIGHT):
		for x in range(0, WIDTH):
			cell = Cell.instance()
			cell.position = Vector2(x * CELL_WIDTH, y * CELL_HEIGHT)
			cell.show_behind_parent = true
			cells[Vector2(x, y)] = cell
			add_child(cell)

	$Collision.position = Vector2(WIDTH * CELL_WIDTH / 2, HEIGHT * CELL_HEIGHT / 2)
	$Collision.scale = $Collision.position


func remove_cells():
	for cell in cells:
		cell.queue_free()
		remove_child(cell)
	cells = {}


func cell_index_at(_global_position):
	var local_pick = _global_position - global_position
	return Vector2(
		clamp(floor(local_pick.x / CELL_WIDTH), 0, WIDTH - 1),
		clamp(floor(local_pick.y / CELL_HEIGHT), 0, HEIGHT - 1)
	)


func cell_at(_global_position):
	return cells[cell_index_at(_global_position)]
