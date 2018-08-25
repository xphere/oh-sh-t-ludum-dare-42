var probabilities = {}
var alias = {}


func _init(weights):
	var lesser = []
	var bigger = []
	var probabilities = {}
	var count = weights.size()
	var total_weight = 0.0

	for weight in weights:
		total_weight += weight

	for index in range(0, count):
		var probability = weights[index] / total_weight * count
		probabilities[index] = probability
		if probability < 1.0:
			lesser.append(index)
		else:
			bigger.append(index)

	while lesser.size() > 0 and bigger.size() > 0:
		var small = lesser.pop_front()
		var large = bigger.pop_front()
		self.probabilities[small] = probabilities[small]
		self.alias[small] = large
		if probabilities[large] + probabilities[small] - 1.0 < 1.0:
			lesser.append(large)
		else:
			bigger.append(large)

	while bigger.size() > 0:
		var large = bigger.pop_front()
		self.probabilities[large] = 1.0

	while lesser.size() > 0:
		var small = lesser.pop_front()
		self.probabilities[small] = 1.0


func roll():
	var index = randi() % probabilities.size()
	var probability = probabilities[index]

	return index if probability == 1.0 or (randf() < probability) else alias[index]
