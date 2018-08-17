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
var currently_placing


func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = event.global_position * $Camera.zoom
		if mouse_position != last_mouse_position:
			$Cursor.position = mouse_position
		return

	if event is InputEventMouseButton and (state == State.PLACING or state == State.PICKED):
		if event.button_index == BUTTON_RIGHT and event.is_pressed():
			$Sound/PieceRotated.play()
			$Cursor.rotation_degrees += 90
			for child in $Cursor/Placeholder.get_children():
				child.rotation_degrees -= 90
			last_mouse_position = null
			return

		if event.button_index == BUTTON_LEFT and event.is_pressed():
			if not correct:
				if state == State.PLACING:
					$Sound/PieceWrong.play()
				return
			$Sound/PiecePlaced.play()
			$Grid.put_cells(
				$Cursor/Placeholder,
				$Cursor/Placeholder.get_meta("piece_color")
			)
			$Cursor/Placeholder.queue_free()
			$Cursor.rotation_degrees = 0
			state = State.IDLE
			currently_placing.delete()
			currently_placing = null


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
	if not state in [State.IDLE, State.PICKED]:
		return

	for child in $Cursor.get_children():
		$Cursor.remove_child(child)
		child.queue_free()
	$Cursor.rotation_degrees = 0

	correct = false
	state = State.PICKED
	var placeholder = bitFactory.create(
		balloon.get_meta("piece_index"),
		balloon.get_meta("piece_color")
	)
	placeholder.modulate = Color(1.0, 1.0, 1.0, 0.75)
	placeholder.set_name("Placeholder")
	placeholder.set_meta("piece_color", balloon.get_meta("piece_color"))
	$Cursor.add_child(placeholder)
	currently_placing = balloon


func _on_Timer_timeout():
	if $InputTrack.new_random_input():
		$Sound/PieceArrived.play()


func _on_Grid_running_out_of_space():
	$Worker/Balloon.visible = true
