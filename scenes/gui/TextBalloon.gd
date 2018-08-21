extends Container

var content


func set(node):
	if content:
		content.queue_free()
		$Patch.remove_child(content)
	$Patch.add_child(node)
	content = node


func delete():
	self.queue_free()
