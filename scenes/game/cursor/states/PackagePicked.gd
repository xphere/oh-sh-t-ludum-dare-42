extends "res://scripts/State.gd"

onready var cursor = $"../.."
var picked_package


func on_start(package):
	picked_package = package
	picked_package.set_selected(true)


func on_stop():
	picked_package.set_selected(false)
	picked_package = null


func on_event_click(element):
	if not element:
		return

	if element == picked_package:
		pop_state()

	elif element.is_in_group("package"):
		replace_state("PackagePicked", element)


func on_event_enter(element):
	if element.is_in_group("grid"):
		push_state("PackagePlacing", element)
