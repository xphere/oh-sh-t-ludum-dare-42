extends Container


func _ready():
	$Collision/Area/Shape.scale = $Border.rect_size / 2.0
