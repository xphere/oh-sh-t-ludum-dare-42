extends Timer

export(NodePath) var conveyor_path = ".." setget set_conveyor_path
export(NodePath) var factory


func set_conveyor_path(path):
	if path != null:
		conveyor_path = path


func _on_timeout():
	var conveyor = get_node(conveyor_path)

	if conveyor.at_full_capacity():
		return

	var package = preload("res://scenes/package/Package.tscn").instance()

	if factory:
		package.from_content(get_node(factory).create())

	conveyor.add_package(package)
