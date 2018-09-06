extends "res://scripts/State.gd"


func on_event_click(element):
	if element and element.is_in_group("package"):
		push_state("PackagePicked", element)
