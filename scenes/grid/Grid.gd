extends Container

const CELL_SIZE = Vector2(7, 7)

var dimensions
var bits = {}


func _ready():
	$Collision/Area/Shape.scale = $Border.rect_size / 2.0
	dimensions = from_relative($Border.rect_size)


func from_relative(relative_position):
	return (relative_position / CELL_SIZE).floor()


func to_relative(relative_position):
	return (relative_position + Vector2(0.5, 0.5)) * CELL_SIZE


func to_local(_global_position):
	var local_position = from_relative(_global_position - $Cells.get_global_position())
	if in_grid(local_position):
		return local_position


func in_grid(local_position):
	return (
		local_position.x >= 0 and
		local_position.y >= 0 and
		local_position.x < dimensions.x and
		local_position.y < dimensions.y
	)


func to_global(local_position):
	return $Cells.rect_global_position + to_relative(local_position)


func fill(local_position, cell):
	bits[local_position] = cell
	cell.position = to_relative(local_position)
	$Cells.add_child(cell)

