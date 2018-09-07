extends RigidBody2D

var entered = false
var selected = false
var state = null
var content = null
var tooltip = null
var placeholder = null


func _ready():
	update_state()


func from_content(new_content):
	content = new_content

	if content.has_node("Tooltip"):
		tooltip = content.get_node("Tooltip").duplicate()
		$Pivot/Tooltip/Balloon/Container.add_child(tooltip)
	else:
		tooltip = null


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

	$Pivot/Tooltip.visible = state and tooltip != null

	$Pivot/Border.visible = state
	if state and not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("Selected")
