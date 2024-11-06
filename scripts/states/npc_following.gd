class_name NPCFollowing extends Node

var max_speed = 150
#@onready var path_line: Line2D = $"../../PathLine"

var map
var target: CharacterBody2D
var character: CharacterBody2D
var path: Array

func _process(delta: float) -> void:
	var target_position = map.tile_position(target.position)
	var character_position = map.tile_position(character.position)

	var graph = Graph.new()
	graph.map = map
	
	var a_star = AStar.new()
	path = a_star.path_building(graph, character_position, target_position)
	#set_path_line(path)
	if path.size() > 1:
		var start: Vector2 = graph.map.game_position(path[0])
		var end = graph.map.game_position(path[1])
		var direction = start.direction_to(end)
		character.velocity = direction * max_speed
		character.rotation = atan2(-character.velocity.x, character.velocity.y)
		character.move_and_slide()
		
#func set_path_line(points: Array):
#	var local_points = []
#	for point in points:
#		local_points.append(Vector2(point.x, point.y))
#		#local_points.append(Vector2(point.x - 36, point.y - 20))
#		#local_points.append(map.game_position(point))
#		#local_points.append(Vector2(point.x - 36, point.y - 20) - map.game_position(point))
#	#print('path line points: ', path_line.points)
#	path_line.points = local_points
