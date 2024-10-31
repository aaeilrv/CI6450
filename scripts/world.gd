extends Node2D

@onready var tile_map: TileMapLayer = $WorldRepresentation/background
@onready var soil_details: TileMapLayer = $WorldRepresentation/soil_obstacles
@onready var obstacles: TileMapLayer = $WorldRepresentation/obstacles

var is_reachable_custom_data = "is_reachable"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	var new_graph = Graph.new()
	new_graph.tile_map = tile_map
	new_graph.soil_details = soil_details
	new_graph.obstacles = obstacles
	
	if Input.is_action_just_pressed("click"):
		var mouse_position = get_global_mouse_position()
		var mouse_to_map = tile_map.local_to_map(mouse_position)
		var new_node = mouse_to_map
		print("node: ", mouse_to_map)
			
		var obtained_connections = new_graph.getConnections(new_node)	
		for connection in obtained_connections:
			print("node connection: ", connection.toNode)
		print("\n")
		
