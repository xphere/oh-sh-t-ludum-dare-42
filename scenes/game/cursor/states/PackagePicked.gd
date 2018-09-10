extends "res://scripts/State.gd"

var picked
var over


func on_start(_picked):
	picked = _picked
	over = _picked

	picked.select(true)

	if picked.has_method("get_placeholder"):
		var placeholder = picked.get_placeholder()
		root.set_placeholder(placeholder)


func on_resume(placed):
	if placed:
		picked.queue_free()
		set_state("Idle")


func on_stop():
	root.set_placeholder(null)
	picked.select(false)


func on_event_click(element):
	if not element:
		return

	if element == picked:
		pop_state(over)

	elif element.is_in_group("package"):
		pop_state(over)
		push_state(name, element)


func on_event_right_click(element):
	root.placeholder_rotate()


func on_event_enter(element):
	if element.is_in_group("grid"):
		push_state("PackagePlacing", element)

	elif element.is_in_group("package") and element != picked:
		set_over(element)


func on_event_leave(element):
	if element == over and element != picked:
		set_over(null)


func set_over(_over):
	if _over == over:
		return

	over.hover(false) if over else null
	over = _over
	over.hover(true) if over else null

	if over == null:
		over = picked
		picked.tooltip(true)
