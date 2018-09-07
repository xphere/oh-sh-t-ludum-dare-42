extends RigidBody2D

var content = null
var tooltip = null
var placeholder = null


func from_content(new_content):
	content = new_content

	if content.has_node("Tooltip"):
		tooltip = content.get_node("Tooltip").duplicate()
		$Pivot/Tooltip/Balloon/Container.add_child(tooltip)
	else:
		tooltip = null

	if content.has_node("Placeholder"):
		placeholder = content.get_node("Placeholder").duplicate()
	else:
		placeholder = null


func get_placeholder():
	return placeholder.duplicate() if placeholder else null


func select(state):
	$Pivot/Tooltip.visible = state and tooltip != null

	$Pivot/Border.visible = state
	if state and not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("Selected")
