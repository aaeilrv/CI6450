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
	#set_path_line(path)
	if npc.path.size() > 1:
		#var start: Vector2 = graph.map.game_position(npc.path[0])
		#var end = graph.map.game_position(npc.path[1])
		#var direction = start.direction_to(end)
		
		var start : Vector2i = npc.path[0] * 16 + cell_size / 2
		var end : Vector2i = npc.path[1] * 16 + cell_size / 2
		var direction = Vector2(start.x, start.y).direction_to(Vector2(end.x, end.y))
		
		#npc.position.x = target_pos.x
		#npc.position.y = target_pos.y
		npc.velocity = direction * max_speed + Vector2.ONE * 8
		#npc.velocity.x = target_pos.x * max_speed
		#npc.velocity.y = target_pos.y * max_speed
		npc.rotation = atan2(-npc.velocity.x, npc.velocity.y)
		npc.pathline.global_rotation = 0
		npc.move_and_slide()
