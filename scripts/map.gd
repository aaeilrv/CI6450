class_name map extends Node2D

@onready var tile_map: TileMapLayer = $background
@onready var soil_details: TileMapLayer = $soil_obstacles
@onready var obstacles: TileMapLayer = $obstacles

var is_reachable_custom_data = "is_reachable"

func tile_position(position: Vector2) -> Vector2i:
	return tile_map.local_to_map(position)

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
