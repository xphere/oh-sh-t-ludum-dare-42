extends Node

const COLORS = [
	Color(0.80, 0.00, 0.00, 1.00),
	Color(0.00, 0.80, 0.00, 1.00),
	Color(0.00, 0.00, 0.80, 1.00),
]

var dice


func _ready():
	var weights = []
	for child in get_children():
		weights.append(int(child.name[-1]))

	dice = Utils.loaded_dice(weights)


func create_random(balloon):
	var shape = dice.roll()
	var prototype = get_child(shape)
	var clone = prototype.duplicate()
	var color = randi() % 3
	clone.modulate = COLORS[color]
	clone.visible = true

	balloon.set(clone)
	balloon.set_meta("piece_shape", shape)
	balloon.set_meta("piece_color", color)

	return clone
