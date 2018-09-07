extends "res://scripts/State.gd"

onready var cursor = $"../.."
var grid


func on_start(grid):
	cursor.snap_to(grid)
	self.grid = grid


func on_stop():
	cursor.snap_to(null)
	grid = null


func on_event_leave(element):
	if element == grid:
		pop_state()
