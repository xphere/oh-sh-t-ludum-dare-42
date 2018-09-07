extends "res://scripts/State.gd"

var selected


func on_stop():
	set_selected(null)


func on_resume():
	set_selected(null)


func on_event_enter(element):
	if element and element.is_in_group("package"):
		set_selected(element)


func on_event_leave(element):
	if element and element == selected:
		set_selected(null)


func on_event_click(element):
	if element and element.is_in_group("package"):
		push_state("PackagePicked", element)


func set_selected(new_selected):
	if selected == new_selected:
		return

	if selected and selected.has_method("select"):
		selected.select(false)

	selected = new_selected
	if selected and selected.has_method("select"):
		selected.select(true)
