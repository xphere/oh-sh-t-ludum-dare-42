extends Node2D

var filled = false


func set(color):
	$Bit.region_rect.position.y = color * 7
	$Bit.visible = true
	filled = true


func unset():
	$Bit.visible = false
	filled = false
