extends Node2D

enum PieceColor {
	RED = 1,
	BLUE = 2,
	GREEN = 4,
	WHITE = 8,
	BLACK = 16,
	MAX = 32,
}

export(int, FLAGS, "Red", "Blue", "Green", "White", "Black") var available_colors
export(float, 0.0, 1.0) var mixed_colors_probability = 0.0

var colors = []
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

	var all_colors = {
		PieceColor.RED: $Pieces/Red/Placeholder,
		PieceColor.BLUE: $Pieces/Blue/Placeholder,
		PieceColor.GREEN: $Pieces/Green/Placeholder,
		PieceColor.WHITE: $Pieces/White/Placeholder,
		PieceColor.BLACK: $Pieces/Black/Placeholder,
	}
	for color in all_colors.keys():
		if available_colors & color:
			colors.push_back(all_colors[color])

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
		piece.center = $Content/Tooltip/Pieces.scale * (max_size - Vector2(1.0, 1.0)) / 2.0


func create():
	var content = $Content.duplicate()

	var color = random_color()
	var piece = possible_pieces[randi() % possible_pieces.size()]
	var tooltip = content.get_node("Tooltip/Pieces")
	tooltip.position = -piece.center

	var use_mixed_colors = randf() < mixed_colors_probability
	for position in piece.positions:
		var bit = color.duplicate()
		bit.offset = position
		tooltip.add_child(bit)
		if use_mixed_colors:
			color = random_color()

	return content


func random_color():
	return colors[randi() % colors.size()]
