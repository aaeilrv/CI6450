extends Node2D

@onready var world_map = $map
@onready var character = $charater_that_moves
@onready var graph: Graph

#@onready var tile_map: TileMapLayer = $WorldRepresentation/background
#@onready var soil_details: TileMapLayer = $WorldRepresentation/soil_obstacles
#@onready var obstacles: TileMapLayer = $WorldRepresentation/obstacles

var is_reachable_custom_data = "is_reachable"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_graph = Graph.new()
	graph = new_graph
	graph.map = world_map

func _input(event):
	#var new_graph = Graph.new()
	#new_graph.map = world_map
	
	if Input.is_action_just_pressed("click"):
		var mouse_position = get_global_mouse_position()
		var mouse_to_map = world_map.tile_position(mouse_position)
		var new_node = TileNode.new()
		new_node.node_position = mouse_to_map
		#print("node: ", mouse_to_map)
		# cofre: (8, 13)
		# queremos llegar al de al lado (7,13)
		
		
			
		#var obtained_connections = new_graph.get_connections(new_node)	
		#for connection in obtained_connections:
		#	print("node connection: ", connection.to_node.node_position)
		#print("\n")
		
		var character_position = world_map.tile_position(character.position)
		var character_node = TileNode.new()
		
		character_node.node_position = character_position
		var a_star = AStar.new()
		var heuristic = Heuristic.new()
		
		var cofre = TileNode.new()
		cofre.node_position = Vector2i(7, 13)
		heuristic.goal_node = cofre
		
		print(character_position)
		
		var x = a_star.a_star_algorithm(graph, character_node, cofre, heuristic)
		print(x)
		
#func _process(delta: float) -> void:
	
	
