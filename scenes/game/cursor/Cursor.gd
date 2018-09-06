extends Area2D

var selection_stack = []
var current_selection


func _input(event):
	if event is InputEventMouseMotion:
		global_position = get_global_mouse_position()

	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
			BUTTON_LEFT: event("click", current_selection)
			BUTTON_RIGHT: event("right_click", current_selection)


func event(event_name, context = null):
	$States.event(event_name, context)


func when_entered(area):
	area = target_of(area)
	if current_selection:
		selection_stack.push_back(current_selection)
	current_selection = area
	event("enter", area)


func when_exited(area):
	area = target_of(area)
	if current_selection == area:
		current_selection = null if selection_stack.empty() else selection_stack.pop_back()
	else:
		selection_stack.erase(area)
	event("leave", area)


func target_of(element):
	if not element.is_in_group("delegate"):
		return element

	while element.get_parent():
		element = element.get_parent()
		if element.is_in_group("target"):
			return element

