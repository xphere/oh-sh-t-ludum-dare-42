extends Area2D

signal click(selected_element)
signal right_click(selected_element)
signal enter(element)
signal leave(element)


var selection_stack = []
var current_selection


func _input(event):
	if event is InputEventMouseMotion:
		global_position = get_global_mouse_position()

	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
			BUTTON_LEFT: emit_signal("click", current_selection)
			BUTTON_RIGHT: emit_signal("right_click", current_selection)


func when_entered(area):
	area = target_of(area)
	if current_selection:
		selection_stack.push_back(current_selection)
		emit_signal("leave", current_selection)
	current_selection = area
	emit_signal("enter", area)


func when_exited(area):
	area = target_of(area)
	emit_signal("leave", area)

	if current_selection != area:
		selection_stack.erase(area)
		return

	if selection_stack.empty():
		current_selection = null
	else:
		current_selection = selection_stack.pop_back()
		emit_signal("enter", current_selection)


func on_event_click(element):
	if element and element.has_method("on_click"):
		element.on_click()
	$States.event("click", element)


func on_event_right_click(element):
	if element and element.has_method("on_right_click"):
		element.on_right_click()
	$States.event("right_click", element)


func on_event_enter(element):
	if element and element.has_method("on_enter"):
		element.on_enter()
	$States.event("enter", element)


func on_event_leave(element):
	if element and element.has_method("on_leave"):
		element.on_leave()
	$States.event("leave", element)


func target_of(element):
	if not element.is_in_group("delegate"):
		return element

	while element.get_parent():
		element = element.get_parent()
		if element.is_in_group("target"):
			return element
