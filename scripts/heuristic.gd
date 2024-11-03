class_name Heuristic extends Node

var goal_node: TileNode

# estimate cost to reach the stored goal from the given node
func estimate(from_node: TileNode) -> float:
	var dx = goal_node.node_position.x - from_node.node_position.x
	var dy = goal_node.node_position.y - from_node.node_position.y
	
	var distance: float
	
	# Euclidian Distance
	distance = sqrt(dx ** 2 + dy ** 2)
	
	# Manhattan distance:
	#distance = abs(dx) + abs(dy)
	
	# Chebyshev distance:
	#distance = max(abs(dx), abs(dy))
	
	return distance

# estimate cost to move between any two nodes
func estimate_between_two(from_node: TileNode, to_node: TileNode) -> float:
	var dx = to_node.node_position.x - from_node.node_position.x
	var dy = to_node.node_position.y - from_node.node_position.y
	
	var distance: float
	# Euclidian Distance
	distance = sqrt(dx ** 2 + dy ** 2)
	
	# Manhattan distance:
	#distance = abs(dx) + abs(dy)
	
	# Chebyshev distance:
	#distance = max(abs(dx), abs(dy))
	
	return distance
