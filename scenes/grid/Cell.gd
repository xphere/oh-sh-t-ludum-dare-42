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
