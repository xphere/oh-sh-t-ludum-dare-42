extends Node

var cursor


func enter(root, parameters):
	root.connect("select_input", self, "_on_select_input")
	root.connect("select_output", self, "_on_select_output")
	root.connect("mouse_moved", self, "_on_mouse_moved")
	cursor = root.get_node("Cursor")


func leave(root):
	root.disconnect("select_input", self, "_on_select_input")
	root.disconnect("select_output", self, "_on_select_output")
	root.disconnect("mouse_moved", self, "_on_mouse_moved")


func _on_select_input(input):
	get_parent().change_to("PiecePicked", input)


func _on_select_output(output):
	get_parent().change_to("RequestPicked", output)


func _on_mouse_moved(position):
	cursor.set_position(position)
