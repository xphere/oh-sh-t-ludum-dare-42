extends RigidBody2D

var content = null
var tooltip = null
var placeholder = null


func from_content(_content):
	content = _content

	if content.has_node("Tooltip"):
		tooltip = content.get_node("Tooltip").duplicate()
		$Pivot/Tooltip/Balloon/Container.add_child(tooltip)
	else:
		tooltip = null

	if content.has_node("Placeholder"):
		placeholder = content.get_node("Placeholder")
	else:
		placeholder = null

	tooltip(false)


func get_placeholder():
	return placeholder.duplicate() if placeholder else null


func select(state):
	$Pivot/Border.visible = state


func hover(state):
	tooltip(state)

	if state and not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("Selected")
	else:
		$AnimationPlayer.seek(0, true)
		$AnimationPlayer.stop()


func tooltip(state):
	$Pivot/Tooltip.visible = state and tooltip != null
