class_name Graph extends Node

@onready var tile_map: TileMapLayer
@onready var soil_details: TileMapLayer
@onready var obstacles: TileMapLayer

var is_reachable_custom_data = "is_reachable"

# If the tile data is not empty, it means it has
# an obstacle in it.
func hasObstacles(TileNode: Vector2i) -> bool:
	var obstacles_in_soil = soil_details.get_cell_tile_data(TileNode)
	var obstacles_sprites = obstacles.get_cell_tile_data(TileNode)
	
	if not obstacles_in_soil and not obstacles_sprites:
		return false
	else:
		return true
		
func isReachable(TileNode: Vector2i) -> bool:
	var tile_data = tile_map.get_cell_tile_data(TileNode)
	if tile_data:
		var is_reachable = tile_data.get_custom_data(is_reachable_custom_data)
		if is_reachable:
			return true
		else:
			return false
	else:
		return false

func validTile(TileNode: Vector2i) -> bool:
	var is_reachable = isReachable(TileNode)
	var has_obstacles = hasObstacles(TileNode)
	
	if is_reachable and not has_obstacles:
		return true
	else:
		return false

# returns array of connections
func getConnections(fromNode: Vector2i) -> Array[Connection]:
	var obtained_connections: Array[Connection] = []
	
	var x = fromNode.x
	var y = fromNode.y
	
	print("is this node valid? ", validTile(fromNode))
	
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
		new_connection.fromNode = fromNode
		new_connection.toNode = all_neighbors[i]
		var is_reachable = validTile(all_neighbors[i])
		if is_reachable:
			obtained_connections.append(new_connection)
		i += 1
	
	return obtained_connections
