extends "res://scripts/State.gd"

var picked_package


func on_start(package):
	picked_package = package
	picked_package.select()


func on_stop():
	picked_package.deselect()
	picked_package = null


func on_event_click(element):
	if not element:
		return

	if element == picked_package:
		pop_state()

	elif element.is_in_group("package"):
		replace_state("PackagePicked", element)
