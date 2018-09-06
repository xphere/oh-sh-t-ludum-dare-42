extends "res://scripts/State.gd"

var picked_package


func on_start(package):
	print("Start picking ", package)
	picked_package = package


func on_event_click(element):
	if not element:
		return

	if element == picked_package:
		pop_state()

	elif element.is_in_group("package"):
		replace_state("PackagePicked", element)
