extends Container

var content
var selected = false


func set(node):
	if content:
		content.queue_free()
		$Patch.remove_child(content)
	$Patch.add_child(node)
	content = node


func delete():
	self.queue_free()


func select():
	selected = true
	$Patch.region_rect.position.y = 7


func unselect():
	selected = false
	$Patch.region_rect.position.y = 0
