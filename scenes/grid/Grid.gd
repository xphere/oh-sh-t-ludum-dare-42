extends StaticBody2D

const CELL_WIDTH = 64
const CELL_HEIGHT = 64
const WIDTH = 8
const HEIGHT = 8

var cells = {}
var tracking = false


func _ready():
	generate_cells()


func _input(event):
	if event is InputEventMouseButton and tracking and event.button_index == BUTTON_LEFT and event.is_pressed():
		var index = to_cell_index(
			get_viewport().get_mouse_position()
		)
		cells[index].toggle()


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
	tracking = true


func on_mouse_leave():
	tracking = false


func to_cell_index(position):
	var local_pick = position - global_position
	return Vector2(
		floor(local_pick.x / CELL_WIDTH),
		floor(local_pick.y / CELL_HEIGHT)
	)
