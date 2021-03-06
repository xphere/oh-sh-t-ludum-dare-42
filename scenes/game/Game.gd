extends Node

signal enter_grid(grid)
signal leave_grid(grid)
signal mouse_moved(position)
signal left_click(position)
signal right_click(position)
signal select_input(input)
signal select_output(output)


var mouse_position


func _ready():
	$States.change_to("Idle")


func _input(event):
	if event is InputEventMouseMotion:
		var position = event.global_position * $Camera.zoom
		if position != mouse_position:
			mouse_position = position
			emit_signal("mouse_moved", position)
		return

	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
			BUTTON_RIGHT: emit_signal("right_click", mouse_position)
			BUTTON_LEFT: emit_signal("left_click", mouse_position)
		return


func _on_Grid_mouse_entered():
	emit_signal("enter_grid", $Grid)


func _on_Grid_mouse_exited():
	emit_signal("leave_grid", $Grid)


func _on_InputTrack_balloon_clicked(input):
	emit_signal("select_input", input)


func _on_OutputTrack_balloon_clicked(output):
	emit_signal("select_output", output)


func _on_Grid_running_out_of_space():
	$Worker/Balloon.visible = true


func _on_piece_rotated():
	$Sound/PieceRotated.play()


func _on_piece_placed():
	$Sound/PiecePlaced.play()


func _on_piece_wrong_placed():
	$Sound/PieceWrong.play()


func _on_balloon_added(balloon):
	$Sound/PieceArrived.play()
