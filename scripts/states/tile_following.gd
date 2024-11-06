class_name TileFollowing extends Node

var target: Vector2i
var npc: CharacterBody2D
var map: Node

var path_line: Line2D
var path

@export var max_speed = 150
@export var cell_size = Vector2i(16, 16)
	
func _process(delta: float) -> void:
	#path_line = npc.pathline
	var target_position = map.tile_position(target)
	var npc_position = map.tile_position(npc.position)

	var graph = Graph.new()
	graph.map = map
	
	var a_star = AStar.new()
	npc.path = a_star.path_building(graph, npc_position, target)
