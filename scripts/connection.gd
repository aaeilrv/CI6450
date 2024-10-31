class_name Connection extends Node

var fromNode: Vector2i
var toNode: Vector2i
var Cost: float = 0

# Calculate eucledian distance to obtain cost:
func getCost() -> float:
	var dx = abs(toNode.x - fromNode.x)
	var dy = abs(toNode.y - fromNode.y)

	if dx <= 1 and dy <= 1:
		return sqrt(dx * dx + dy * dy)
	else:
		return INF
