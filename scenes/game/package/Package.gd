extends RigidBody2D

var entered = false
var selected = false
var state = false


func on_enter():
	entered = true
	update_state()


func on_leave():
	entered = false
	update_state()


func set_selected(value):
	selected = value
	update_state()


func update_state():
	var next_state = entered or selected
	if next_state == state:
		return

	state = next_state
	$Pivot/Border.visible = state
	if state and not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("Selected")
