extends Node2D

enum PieceColor {
	RED = 1,
	BLUE = 2,
	GREEN = 4,
	WHITE = 8,
	BLACK = 16,
}

export(int, FLAGS, "Red", "Blue", "Green", "White", "Black") var available_colors
export(bool) var mix_colors = false

var possible_pieces = [
	{
		"shape": [
			"x",
		],
	},
	{
		"shape": [
			"x ",
			"xx",
		],
	},
	{
		"shape": [
			"xx",
			"xx",
		],
	},
	{
		"shape": [
			"xx",
			" xx",
		],
	},
	{
		"shape": [
			" xx",
			"xx",
		],
	},
	{
		"shape": [
			"x  ",
			"xxx",
		],
	},
	{
		"shape": [
			"  x",
			"xxx",
		],
	},
]

func _ready():
	randomize()
	for piece in possible_pieces:
		var positions = []
		var position = Vector2(0, 0)
		var max_size = Vector2(0, 0)
		for row in piece.shape:
			max_size = Vector2(
				max(max_size.x, row.length()),
				max(max_size.y, position.y)
			)
			for column in row:
				if column != " ":
					positions.push_back(position)
				position.x += 1
			position = Vector2(0, position.y + 1)
		piece.positions = positions
		piece.center = max_size / 2.0 - Vector2(0.5, 0.5)


func create():
	var content = $Content.duplicate()

	var piece = possible_pieces[randi() % possible_pieces.size()]
	var tooltip = content.get_node("Tooltip/Pieces")
	tooltip.position = -piece.center
	for position in piece.positions:
		var bit = $Pieces/Red/Placeholder.duplicate()
		bit.offset = position
		tooltip.add_child(bit)

	return content
