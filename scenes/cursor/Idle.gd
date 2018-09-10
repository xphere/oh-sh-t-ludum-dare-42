extends "res://scripts/State.gd"

var over


func on_stop():
	set_over(null)


func on_resume(over):
	set_over(over)


func on_event_enter(element):
	if element and element.is_in_group("package"):
		set_over(element)


func on_event_leave(element):
	if element and element == over:
		set_over(null)


func on_event_click(element):
	if element and element.is_in_group("package"):
		push_state("PackagePicked", element)


func set_over(_over):
	if _over == over:
		return

	over.hover(false) if over else null
	over = _over
	over.hover(true) if over else null
