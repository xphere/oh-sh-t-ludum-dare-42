extends Node

class WeightedRand:
	var weights = []
	var total = 0


	func add(weight):
		weights.append(weight)
		total += weight


	func rand():
		var rand = randi() % total
		var index = 0
		for weight in weights:
			if rand < weight:
				return index
			index += 1
			rand -= weight
		return index


const COLORS = [
	Color(0.80, 0.00, 0.00, 1.00),
	Color(0.00, 0.80, 0.00, 1.00),
	Color(0.00, 0.00, 0.80, 1.00),
]

var weights


func _ready():
	weights = WeightedRand.new()
	for child in get_children():
		var weight = int(child.name[-1]) # Weight is last character of name
		weights.add(weight)


func create_random(balloon):
	var shape = weights.rand()
	var prototype = get_child(shape)
	var clone = prototype.duplicate()
	var color = randi() % 3
	clone.modulate = COLORS[color]
	clone.visible = true

	balloon.set(clone)
	balloon.set_meta("piece_shape", shape)
	balloon.set_meta("piece_color", color)

	return clone
