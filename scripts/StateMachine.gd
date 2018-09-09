extends Node

var stack = []
var current_state
export(NodePath) var root_path = ".."
export(NodePath) var initial_state = null


func _ready():
	var root = get_node(root_path)
	for child in get_children():
		child.root = root

	if initial_state:
		set_state(initial_state)


func event(event_name, argument = null):
	if not current_state:
		return

	if current_state.has_method("on_event_" + event_name):
		current_state.call("on_event_" + event_name, argument)
	else:
		current_state.on_event(event_name, argument)


func set_state(state_name, context = null):
	if current_state:
		current_state.on_stop()

	while not stack.empty():
		var previous_state = stack.pop_back()
		previous_state.on_stop()

	current_state = get_node(state_name)
	current_state.on_start(context)


func push_state(state_name, context = null):
	current_state.on_pause()
	stack.push_back(current_state)
	current_state = get_node(state_name)
	current_state.on_start(context)


func pop_state(context = null):
	current_state.on_stop()
	current_state = stack.pop_back()
	current_state.on_resume(context)
