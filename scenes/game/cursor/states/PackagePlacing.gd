extends "res://scripts/State.gd"

var grid


func on_start(_grid):
	grid = _grid
	root.snap_to(grid)


func on_stop():
	root.snap_to(null)


func on_event_leave(element):
	if element == grid:
		pop_state()
