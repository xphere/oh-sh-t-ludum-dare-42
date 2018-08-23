extends Node2D

var filled = false
var color


func set(_color):
	color = _color
	$Bit.region_rect.position.y = color * 7
	$Bit.visible = true
	filled = true


func unset():
	color = null
	$Bit.visible = false
	filled = false


func connected_with(top, right, bottom, left):
	$Floor.region_rect.position = Vector2(
		(8 if top else 0) + (16 if right else 0),
		(8 if bottom else 0) + (16 if left else 0)
	)
