class_name Heuristic extends Node

static func estimate(from_node: Vector2i, to_node: Vector2i) -> float:
	var dx = to_node.x - from_node.x
	var dy = to_node.y - from_node.y
	
	var distance: float
	# Euclidian Distance
	#distance = sqrt(dx ** 2 + dy ** 2)
	
	# Manhattan distance:
	distance = abs(dx) + abs(dy)
	
	# Chebyshev distance:
	#distance = max(abs(dx), abs(dy))
	
	return distance
