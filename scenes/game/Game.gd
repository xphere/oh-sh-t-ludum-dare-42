extends Node

enum State {
	IDLE = 0,
	PICKED = 1,
	PLACING = 2,
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
			state = State.IDLE


func _process(delta):
	if mouse_position == last_mouse_position:
		return

	if state == State.PLACING:
		$Cursor.position = $Grid.cell_at(mouse_position).global_position

	last_mouse_position = mouse_position


func _on_Grid_mouse_entered():
	if state == State.PICKED:
		state = State.PLACING
		$Cursor/Placeholder.visible = true


func _on_Grid_mouse_exited():
	if state == State.PLACING:
		state = State.IDLE
		$Cursor/Placeholder.visible = false


func _on_Piece_input_event(viewport, event, shape_idx):
	if not event is InputEventMouseButton:
		return

	if state == State.IDLE:
		state = State.PICKED
