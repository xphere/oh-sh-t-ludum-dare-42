extends Container

const CELL_SIZE = Vector2(7, 7)

var dimensions


func _ready():
	$Collision/Area/Shape.scale = $Border.rect_size / 2.0
	dimensions = ($Border.rect_size / CELL_SIZE).floor()


func to_local(_global_position):
	var local = ((_global_position - $Cells.get_global_position()) / CELL_SIZE).floor()
	if local.x >= 0 and local.y >= 0 and local.x < dimensions.x and local.y < dimensions.y:
		return local


func to_global(local_position):
	return $Cells.rect_global_position + (local_position * CELL_SIZE)
