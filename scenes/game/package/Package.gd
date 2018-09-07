extends RigidBody2D


func select():
	$AnimationPlayer.play("Selected")
	pass


func deselect():
	pass
