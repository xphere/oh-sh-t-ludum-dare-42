extends Node

signal piece_picked(shape, color)
signal piece_rotated()

var picked
var cursor


func enter(root, input):
	root.connect("enter_grid", self, "_on_enter_grid")
	root.connect("select_input", self, "_on_select_input")
	root.connect("select_output", self, "_on_select_output")
	root.connect("mouse_moved", self, "_on_mouse_moved")
	root.connect("right_click", self, "_on_right_click")

	cursor = root.get_node("Cursor")
	if picked != input:
		set_picked(input)


func leave(root):
	root.disconnect("enter_grid", self, "_on_enter_grid")
	root.disconnect("select_input", self, "_on_select_input")
	root.disconnect("select_output", self, "_on_select_output")
	root.disconnect("mouse_moved", self, "_on_mouse_moved")
	root.disconnect("right_click", self, "_on_right_click")


func _on_enter_grid(grid):
	get_parent().change_to("PiecePlacing", picked)


func _on_select_input(input):
	var is_selected = input.selected
	clean()
	if is_selected:
		get_parent().change_to("Idle")
	else:
		get_parent().change_to("PiecePicked", input)


func _on_select_output(output):
	clean()
	get_parent().change_to("RequestPicked", output)


func _on_mouse_moved(position):
	cursor.set_position(position)


func _on_right_click(position):
	cursor.rotate()
	emit_signal("piece_rotated")


func set_picked(input):
	picked.unselect() if picked else null
	picked = input
	var shape = picked.get_meta("piece_shape")
	var color = picked.get_meta("piece_color")
	cursor.set_placeholder($BitFactory.create(shape, color))
	emit_signal("piece_picked", shape, color)
	picked.select()


func clean():
	if picked:
		picked.unselect()
		picked = null
