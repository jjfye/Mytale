extends Polygon2D

func _ready():
	var collision_shape = CollisionPolygon2D.new()
	collision_shape.polygon = polygon
	$StaticBody2D.add_child(collision_shape)
