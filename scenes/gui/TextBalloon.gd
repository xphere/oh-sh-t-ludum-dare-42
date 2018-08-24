extends Container

var content
var selected = false


func set(node):
	$AnimationPlayer.play("Enter")
	$AnimationPlayer.seek(0, true)
	$Patch.add_child(node)
	content = node


func delete():
	$AnimationPlayer.play("Leave")


func select():
	selected = true
	$Patch.region_rect.position.y = 7


func unselect():
	selected = false
	$Patch.region_rect.position.y = 0
