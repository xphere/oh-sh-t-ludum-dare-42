extends Node2D

var width = 16
var height = 16
var color = Color(1, 1, 1, 1)


func _draw():
	draw_polyline(
		PoolVector2Array([
			Vector2(0, 0),
			Vector2(0, height),
			Vector2(width, height),
			Vector2(width, 0),
			Vector2(0, 0),
		]),
		color
	)
