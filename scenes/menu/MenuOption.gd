extends Container

export(String, FILE, "*.tscn;*.scn") var next_scene


func _on_mouse_entered():
	$Options.region_rect.position.x = 65


func _on_mouse_exited():
	$Options.region_rect.position.x = 0


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		get_tree().change_scene(next_scene)
