extends Node2D

@onready var world_map = $map
@onready var character = $charater_that_moves
@onready var graph: Graph

@export var show_nodes: bool

var is_reachable_custom_data = "is_reachable"

func _input(event):
	# hide nodes or not
	if Input.is_action_just_pressed("right_click"):
		show_nodes = !show_nodes
		if not show_nodes:
			$".".get_child(7).hide()
		if show_nodes:
			$".".get_child(7).show()
		
	if Input.is_action_just_pressed("click"):
		var mouse_position = get_global_mouse_position()
		var mouse_to_map = world_map.tile_position(mouse_position)
		var new_node = mouse_to_map
		
		print("global mouse position: ", mouse_position)
		print("local mouse position: ", mouse_to_map)
