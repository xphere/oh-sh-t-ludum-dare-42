extends Node

signal request_matched()
signal request_wrong_matched()

var picked
var grid
var cursor
var correct


func enter(root, input):
	root.connect("leave_grid", self, "_on_leave_grid")
	root.connect("mouse_moved", self, "_on_mouse_moved")
	root.connect("left_click", self, "_on_left_click")

	grid = root.get_node("Grid")
	cursor = root.get_node("Cursor")
	picked = input


func leave(root):
	root.disconnect("leave_grid", self, "_on_leave_grid")
	root.disconnect("mouse_moved", self, "_on_mouse_moved")
	root.disconnect("left_click", self, "_on_left_click")
	picked = null


func _on_leave_grid(grid):
	cursor.reset_correctness()
	get_parent().change_to("RequestPicked", picked)


func _on_mouse_moved(position):
	cursor.position = grid.cell_at(position).global_position
	var amount = picked.get_meta("request_amount")
	var color = picked.get_meta("request_color")
	correct = cursor.check_requirements(grid, amount, color)


func _on_left_click(position):
	if not correct:
		emit_signal("request_wrong_matched")
		return

	cursor.remove_adjacents(grid)
	picked.delete()
	cursor.reset()

	emit_signal("request_matched")
	get_parent().change_to("Idle")
