class_name Connection extends Node

var from_node: Vector2i
var to_node: Vector2i
var cost: float = 0

# Calculate eucledian distance to obtain cost:
func get_cost() -> float:
	var dx = abs(to_node.x - from_node.x)
	var dy = abs(to_node.y - from_node.y)

	if dx <= 1 and dy <= 1:
		return sqrt(dx * dx + dy * dy)
	else:
		return INF

func get_from_node() -> Vector2i:
	return from_node
	
func get_to_node() -> Vector2i:
	return to_node

#func _to_string() -> String:
#	return str(from_node) + "->" + str(to_node) + "\n"
	
