class_name Grid extends Node2D

@export var cell_size = Vector2i(16, 16)
@onready var world_map = get_tree().get_first_node_in_group("Map")
var grid_size

func enter():
	world_map = get_tree().get_first_node_in_group("Map")

func _ready() -> void:
	initialize_grid()
	_draw()
	
func initialize_grid():
	grid_size = Vector2i(get_viewport_rect().size) / cell_size
	
func _draw():
	draw_grid()
	draw_center()
	
func draw_center():
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			if x == x and y == y:
				var center_position = Vector2(x * cell_size.x + cell_size.x / 2, y * cell_size.y + cell_size.y / 2)
				var is_valid = world_map.validTile(Vector2i(x, y))
				var color = Color.AQUA
				if not is_valid:
					color = Color.RED 
				else:
					color = Color.AQUA
				draw_circle(center_position, 2.0, color)

func draw_grid():
	for x in grid_size.x + 1:
		draw_line(Vector2(x * cell_size.x, 0),
			Vector2(x * cell_size.x, grid_size.y * cell_size.y),
			Color.DARK_GRAY, 2.0)
	for y in grid_size.y + 1:
		draw_line(Vector2(0, y * cell_size.y),
			Vector2(grid_size.x * cell_size.x, y * cell_size.y),
			Color.DARK_GRAY, 2.0)
