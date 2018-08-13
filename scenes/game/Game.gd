extends Node

enum State {
	IDLE = 0,
	PICKED = 1,
	PLACING = 2,
}

var bitFactory = preload("res://scenes/game/BitFactory.tscn").instance()


var state = State.IDLE
var mouse_position
var last_mouse_position
var correct = false


func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = event.global_position * $Camera.zoom
		if mouse_position != last_mouse_position:
			$Cursor.position = mouse_position
		return

	if event is InputEventMouseButton and state == State.PLACING:
		if event.button_index != BUTTON_LEFT or not event.is_pressed() or not correct:
			return

		$Grid.put_cells(
			$Cursor/Placeholder,
			$Cursor/Placeholder.get_meta("piece_color")
		)
		$Cursor/Placeholder.queue_free()
		state = State.IDLE


func _process(delta):
	if mouse_position == last_mouse_position:
		return
	if state == State.PLACING:
		$Cursor.position = $Grid.cell_at(mouse_position).global_position
		correct = $Grid.check_cells($Cursor/Placeholder)
	last_mouse_position = mouse_position


func _on_Grid_mouse_entered():
	if state == State.PICKED:
		state = State.PLACING


func _on_Grid_mouse_exited():
	if state == State.PLACING:
		state = State.PICKED
		for child in $Cursor/Placeholder.get_children():
			child.region_rect.position.x = 0


func _on_InputTrack_balloon_clicked(balloon):
	if state != State.IDLE:
		return
	correct = false
	state = State.PICKED
	var placeholder = bitFactory.create(
		balloon.get_meta("piece_index"),
		balloon.get_meta("piece_color")
	)
	placeholder.set_name("Placeholder")
	placeholder.set_meta("piece_color", balloon.get_meta("piece_color"))
	$Cursor.add_child(placeholder)
	balloon.delete()
