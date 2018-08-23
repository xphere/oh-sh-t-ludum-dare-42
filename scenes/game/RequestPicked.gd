extends Node

signal request_picked(amount, color)

var picked
var cursor


func enter(root, request):
	root.connect("enter_grid", self, "_on_enter_grid")
	root.connect("select_input", self, "_on_select_input")
	root.connect("select_output", self, "_on_select_output")
	root.connect("mouse_moved", self, "_on_mouse_moved")

	cursor = root.get_node("Cursor")
	if picked != request:
		set_picked(request)


func leave(root):
	root.disconnect("enter_grid", self, "_on_enter_grid")
	root.disconnect("select_input", self, "_on_select_input")
	root.disconnect("select_output", self, "_on_select_output")
	root.disconnect("mouse_moved", self, "_on_mouse_moved")


func _on_enter_grid(grid):
	get_parent().change_to("RequestMatching", picked)


func _on_select_input(input):
	get_parent().change_to("PiecePicked", input)


func _on_select_output(output):
	get_parent().change_to("RequestPicked", output)


func _on_mouse_moved(position):
	cursor.set_position(position)


func set_picked(request):
	picked = request
	var amount = picked.get_meta("request_amount")
	var color = picked.get_meta("request_color")
	request = request.duplicate()
	request.rect_position = Vector2(-4, -picked.rect_size.y)
	cursor.set_placeholder(request)
	emit_signal("request_picked", amount, color)


func clean():
	picked = null
