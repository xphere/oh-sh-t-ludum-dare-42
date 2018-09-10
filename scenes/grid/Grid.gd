extends Container

const CELL_SIZE = Vector2(7, 7)

var dimensions
var bits = {}

enum Directions {
	Top = 1,
	Right = 2,
	Bottom = 4,
	Left = 8,
	TopLeft = 16,
	TopRight = 32,
	RightBottom = 64,
	BottomLeft = 128,
}

var corners = {
	Top | Right: {
		TopRight: Vector2(0, 2),
	},
	Right | Bottom: {
		RightBottom: Vector2(1, 2),
	},
	Top | Right | Bottom: {
		TopRight: Vector2(2, 2),
		RightBottom: Vector2(3, 2),
		TopRight | RightBottom: Vector2(4, 2),
	},
	Top | Left: {
		TopLeft: Vector2(5, 2),
	},
	Top | Right | Left: {
		TopLeft: Vector2(6, 2),
		TopRight: Vector2(7, 2),
		TopLeft | TopRight: Vector2(0, 3),
	},
	Bottom | Left: {
		BottomLeft: Vector2(1, 3),
	},
	Top | Bottom | Left: {
		TopLeft: Vector2(2, 3),
		BottomLeft: Vector2(3, 3),
		TopLeft | BottomLeft: Vector2(4, 3),
	},
	Right | Bottom | Left: {
		BottomLeft: Vector2(5, 3),
		RightBottom: Vector2(6, 3),
		RightBottom | BottomLeft: Vector2(7, 3),
	},
	Top | Right | Bottom | Left: {
		TopLeft: Vector2(0, 4),
		TopRight: Vector2(1, 4),
		RightBottom: Vector2(2, 4),
		BottomLeft: Vector2(3, 4),
		TopLeft | TopRight: Vector2(4, 4),
		TopLeft | RightBottom: Vector2(5, 4),
		TopLeft | BottomLeft: Vector2(6, 4),
		TopRight | RightBottom: Vector2(7, 4),
		TopRight | BottomLeft: Vector2(0, 5),
		RightBottom | BottomLeft: Vector2(1, 5),
		TopLeft | TopRight | RightBottom: Vector2(2, 5),
		TopRight | RightBottom | BottomLeft: Vector2(3, 5),
		TopLeft | RightBottom | BottomLeft: Vector2(4, 5),
		TopLeft | TopRight | BottomLeft: Vector2(5, 5),
		TopLeft | TopRight | RightBottom | BottomLeft: Vector2(6, 5),
	},
}

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


func is_free(local_position):
	return in_grid(local_position) and not bits.has(local_position)


func fill(local_position, cell):
	bits[local_position] = cell
	cell.position = to_relative(local_position)
	$Cells.add_child(cell)
	set_process(true)


func remove(cell):
	for index in bits.keys():
		if bits[index] == cell:
			bits.erase(index)
			break
	cell.queue_free()
	set_process(true)


func adjacents(local_position):
	return adjacents_at(bit_color(local_position), local_position, {})


func adjacents_at(color, local_position, checked):
	if not color:
		return []

	if checked.has(local_position):
		return []

	checked[local_position] = true

	if bit_color(local_position) != color:
		return []

	return (
		adjacents_at(color, local_position - Vector2(1, 0), checked) +
		adjacents_at(color, local_position + Vector2(0, 1), checked) +
		adjacents_at(color, local_position + Vector2(1, 0), checked) +
		adjacents_at(color, local_position - Vector2(0, 1), checked) +
		[bits[local_position]]
	)


func _process(delta):
	update_cells()
	set_process(false)


func update_cells():
	for local in bits.keys():
		var color = bit_color(local)
		var directions = directions(local, color)
		var region = Vector2(directions & (Top | Right | Bottom), sign(directions & Left))
		var diagonals = diagonals(local, color, directions) if corners.has(directions) else null

		if diagonals:
			region = corners[directions][diagonals]

		bits[local].region_rect.position = (region * 8) + Vector2(1, 1)


func mask(value, mask):
	return value & mask == mask


func directions(local, color):
	var directions = 0

	if color == bit_color(local - Vector2(0, 1)):
		directions |= Top
	if color == bit_color(local + Vector2(1, 0)):
		directions |= Right
	if color == bit_color(local + Vector2(0, 1)):
		directions |= Bottom
	if color == bit_color(local - Vector2(1, 0)):
		directions |= Left

	return directions


func diagonals(local, color, directions):
	var diagonals = 0

	if mask(directions, Top | Left) and color == bit_color(local + Vector2(-1, -1)):
		diagonals |= TopLeft
	if mask(directions, Top | Right) and color == bit_color(local + Vector2(+1, -1)):
		diagonals |= TopRight
	if mask(directions, Right | Bottom) and color == bit_color(local + Vector2(+1, +1)):
		diagonals |= RightBottom
	if mask(directions, Bottom | Left) and color == bit_color(local + Vector2(-1, +1)):
		diagonals |= BottomLeft

	return diagonals


func bit_color(local):
	return bits[local].get_meta("color") if bits.has(local) else null
