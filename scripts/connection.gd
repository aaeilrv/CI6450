class_name Connection extends Node

var from_node: TileNode
var to_node: TileNode
var cost: float = 0

# Calculate eucledian distance to obtain cost:
func get_cost() -> float:
	var dx = abs(to_node.node_position.x - from_node.node_position.x)
	var dy = abs(to_node.node_position.y - from_node.node_position.y)

	if dx <= 1 and dy <= 1:
		return sqrt(dx * dx + dy * dy)
	else:
		return INF

func get_from_node() -> TileNode:
	return from_node
	
func get_to_node() -> TileNode:
	return to_node
