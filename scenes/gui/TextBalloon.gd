extends Container

func set(node):
	for child in $Patch.get_children():
		$Patch.remove_child(child)
		child.queue_free()
	add(node)
	

func add(node):
	$Patch.add_child(node)


func delete():
	self.queue_free()
