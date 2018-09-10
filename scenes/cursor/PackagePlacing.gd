extends "res://scripts/State.gd"

var grid
var correct


func on_start(_grid):
	grid = _grid
	root.snap_to(grid)
	check_if_applies()


func on_stop():
	root.snap_to(null)
	root.placeholder_reset()


func on_event_leave(element):
	if element == grid:
		pop_state(false)


func on_event_click(element):
	if correct:
		root.placeholder_apply_to(grid)
		pop_state(true)


func on_event_right_click(element):
	root.placeholder_rotate()
	check_if_applies()


func on_event_local_move(position):
	check_if_applies()


func check_if_applies():
	correct = root.placeholder_check_into(grid)
