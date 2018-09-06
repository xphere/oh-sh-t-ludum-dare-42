extends Position2D

export(NodePath) var input_path


func _input(event):
	if input_path and Input.is_action_just_pressed("ui_accept"):
		get_node(input_path).add_package(preload("res://scenes/game/Package.tscn").instance())
