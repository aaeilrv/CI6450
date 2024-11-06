class_name Map extends Node2D

@onready var tile_map: TileMapLayer = $background
@onready var soil_details: TileMapLayer = $soil_obstacles
@onready var obstacles: TileMapLayer = $obstacles

@onready var npc_1: CharacterBody2D = $"../NPC1"
@onready var npc_2: CharacterBody2D = $"../NPC2"
@onready var npc_3: CharacterBody2D = $"../NPC3"

var is_reachable_custom_data = "is_reachable"

func tile_position(position: Vector2) -> Vector2i:
	return tile_map.local_to_map(position)
	
func game_position(position: Vector2i) -> Vector2:
	return tile_map.map_to_local(position)
	
func isOccupied(TileNode: Vector2i) -> bool:
	if TileNode == tile_position(npc_1.position):
		return true
	if TileNode == tile_position(npc_2.position):
		return true
	if TileNode == tile_position(npc_3.position):
		return true
	else:
		return false

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
	var new_node = Vector2i(TileNode.x - 36, TileNode.y - 20)
	var is_reachable = isReachable(new_node)
	var has_obstacles = hasObstacles(new_node)
	if is_reachable and not has_obstacles:
		return true
	else:
		return false
