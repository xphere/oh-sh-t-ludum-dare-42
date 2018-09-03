extends Node

signal piece_placed()
signal piece_rotated()
signal piece_wrong_placed()

var picked
var grid
var cursor
var correct


func enter(root, input):
	root.connect("leave_grid", self, "_on_leave_grid")
	root.connect("mouse_moved", self, "_on_mouse_moved")
	root.connect("left_click", self, "_on_left_click")
	root.connect("right_click", self, "_on_right_click")

	grid = root.get_node("Grid")
	cursor = root.get_node("Cursor")
	correct = cursor.check_grid(grid)
	picked = input


func leave(root):
	root.disconnect("leave_grid", self, "_on_leave_grid")
	root.disconnect("mouse_moved", self, "_on_mouse_moved")
	root.disconnect("left_click", self, "_on_left_click")
	root.disconnect("right_click", self, "_on_right_click")

	picked = null


func _on_leave_grid(grid):
	cursor.reset_correctness()
	get_parent().change_to("PiecePicked", picked)


func _on_mouse_moved(position):
	cursor.position = grid.cell_at(position).global_position
	correct = cursor.check_grid(grid)


func _on_left_click(position):
	if not correct:
		emit_signal("piece_wrong_placed")
		return

	cursor.put_cells(grid, picked.get_meta("piece_color"))
	picked.delete()

	emit_signal("piece_placed")
	get_parent().change_to("Idle")


func _on_right_click(position):
	cursor.rotate()
	correct = cursor.check_grid(grid)
	emit_signal("piece_rotated")
