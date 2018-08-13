extends StaticBody2D

const CELL_WIDTH = 64
const CELL_HEIGHT = 64
const WIDTH = 12
const HEIGHT = 8

var cells = {}


func _ready():
	generate_cells()


func generate_cells():
	var cell
	var Cell = preload("Cell.tscn")

	for y in range(0, HEIGHT):
		for x in range(0, WIDTH):
			cell = Cell.instance()
			cell.width = CELL_WIDTH
			cell.height = CELL_HEIGHT
			cell.position = Vector2(x * CELL_WIDTH, y * CELL_HEIGHT)
			cells[Vector2(x, y)] = cell
			add_child(cell)

	$Collision.position = Vector2(WIDTH * CELL_WIDTH / 2, HEIGHT * CELL_HEIGHT / 2)
	$Collision.scale = $Collision.position


func remove_cells():
	for cell in cells:
		cell.queue_free()
		remove_child(cell)
	cells = {}


func on_mouse_enter():
	print("Hover!")


func on_mouse_leave():
	print("Leaving!")
