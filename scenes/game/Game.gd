extends Node

enum State {
	IDLE = 0,
	PLACING = 1,
}

var state = State.IDLE
var mouse_position
var last_mouse_position


func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = event.global_position * $Camera.zoom
		return

	if state == State.PLACING and event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			$Grid.cell_at(mouse_position).toggle()


func _process(delta):
	if mouse_position == last_mouse_position:
		return

	if state == State.PLACING:
		$Cursor.position = $Grid.cell_at(mouse_position).global_position

	last_mouse_position = mouse_position


func _on_Grid_mouse_entered():
	state = State.PLACING
	$Cursor/Placeholder.visible = true


func _on_Grid_mouse_exited():
	state = State.IDLE
	$Cursor/Placeholder.visible = false
