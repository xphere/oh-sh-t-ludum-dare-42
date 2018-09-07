extends "res://scripts/State.gd"

onready var cursor = $"../.."
var package
var placeholder
var selected


func on_start(picked_package):
	package = picked_package

	if package.has_method("get_placeholder"):
		placeholder = package.get_placeholder()
		cursor.set_placeholder(placeholder)


func on_stop():
	cursor.set_placeholder(null)
	placeholder = null
	package = null


func on_event_click(element):
	if not element:
		return

	if element == package:
		pop_state()

	elif element.is_in_group("package"):
		replace_state("PackagePicked", element)


func on_event_enter(element):
	if element.is_in_group("grid"):
		push_state("PackagePlacing", element)

	elif element.is_in_group("package") and element != package:
		set_selected(element)


func on_event_leave(element):
	if element == selected:
		set_selected(null)


func set_selected(new_selected):
	if selected == new_selected:
		return

	if selected and selected.has_method("select"):
		selected.select(false)

	selected = new_selected
	if selected and selected.has_method("select"):
		selected.select(true)

	if package.has_method("select"):
		package.select(selected == null)
