extends Container

enum Movement {
	Input,
	Output,
}

export(int, 1, 10) var max_capacity = 5
export(Movement) var movement = Movement.Input setget set_movement

var package_position
var package_force


func _ready():
	match movement:
		Movement.Input:
			package_position = $ConveyorBelt/Belt/InputPosition.global_position
			package_force = $ConveyorBelt/Extreme/OutputPosition.global_position - package_position
			$AnimationPlayer.playback_speed = 1

		Movement.Output:
			package_position = $ConveyorBelt/Extreme/OutputPosition.global_position
			package_force = $ConveyorBelt/Belt/InputPosition.global_position - package_position
			$AnimationPlayer.playback_speed = -1

	# FIXBUG RigidBody2D appears y-reversed when inside of a x-reversed Control
	$Elements.scale.x = rect_scale.x


func set_movement(value):
	if value != null:
		movement = value


func at_full_capacity():
	return $Elements.get_child_count() == max_capacity


func add_package(package):
	if at_full_capacity():
		printerr("Can't add package to already full conveyor belt.")
		return

	$Elements.add_child(package)
	package.set_global_position(package_position)
	package.add_force(get_global_rect().position, package_force)
