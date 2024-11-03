class_name Graph extends Node

@onready var map: Node2D

# returns array of connections
func get_connections(fromNode: Vector2i) -> Array[Connection]:
	var obtained_connections: Array[Connection] = []
	
	var x = fromNode.x
	var y = fromNode.y
	
	var all_neighbors = [
		Vector2i(x - 1, y + 1),
		Vector2i(x, y + 1),
		Vector2i(x + 1, y + 1),
		Vector2i(x - 1, y),
		Vector2i(x + 1, y),
		Vector2i(x - 1, y - 1),
		Vector2i(x, y - 1),
		Vector2i(x + 1, y - 1)
	]
	
	var i = 0
	while i < 8:
		var new_connection = Connection.new()
		var to_node = all_neighbors[i]
		new_connection.from_node = fromNode
		new_connection.to_node = to_node
		var is_valid = map.validTile(all_neighbors[i])
		if is_valid:
			obtained_connections.append(new_connection)
		obtained_connections.append(new_connection)
		i += 1
	
	return obtained_connections
