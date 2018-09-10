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

const all_colors = {
	PieceColor.RED: Color("cb0000"),
	PieceColor.BLUE: Color("0000cb"),
	PieceColor.GREEN: Color("00cb00"),
	PieceColor.WHITE: Color("cbcbcb"),
	PieceColor.BLACK: Color("333333"),
}

var colors = []

func _ready():
	randomize()

	for color in all_colors.keys():
		if available_colors & color:
			colors.push_back(color)


func create():
	var content = $Blueprint.duplicate()
	var color = random_color()
	var amount = 1 + randi() % 8

	var tooltip = content.get_node("Tooltip/Tooltip")
	tooltip.text = "%d" % amount
	tooltip.modulate = all_colors[color]

	var placeholder = content.get_node("Placeholder")
	placeholder.set_meta("color", color)
	placeholder.set_meta("amount", amount)

	return content


func random_color():
	return colors[randi() % colors.size()]
