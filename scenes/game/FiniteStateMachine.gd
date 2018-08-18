extends Node

export(NodePath) var root = ".."

var state


func change_to(name, parameters = []):
	if not has_node(name):
		printerr("State '%s' not found" % name)
		return

	var root = get_node(self.root)
	state.leave(root) if state else false

	var next_state = get_node(name)
	state = next_state
	state.enter(root, parameters) if state else false
