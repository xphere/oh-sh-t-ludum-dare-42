extends "res://scripts/State.gd"

onready var cursor = $"../.."
var package
var placeholder


func on_start(picked_package):
	package = picked_package
	package.set_selected(true)
	if package.has_method("get_placeholder"):
		placeholder = package.get_placeholder()
		cursor.set_placeholder(placeholder)


func on_stop():
	cursor.set_placeholder(null)
	placeholder = null
	package.set_selected(false)
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
