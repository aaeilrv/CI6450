extends CharacterBody2D

signal state_changed(new_state)

enum State {
	WOODS_ONE,
	WOODS_TWO,
	WOODS_THREE
}

@export var storage: bool = true
@export var coins: bool = true
var time = 50

var current_state: int = State.WOODS_ONE : set = set_state
@onready var NPC: CharacterBody2D = $"."
@onready var map: Map = $"../map"
@onready var first_enemy = $"../NPC1"
@onready var second_enemy = $"../NPC3"
@onready var pathline = $PathLine
var path: Array
@export var cell_size = Vector2i(16, 16)

func set_state(new_state: int):
	if new_state == current_state:
		return
	else:
		current_state = new_state
		emit_signal("state_changed", current_state)

func _process(delta: float) -> void:
	match current_state:
		State.WOODS_ONE:
			var go_to_woods = TileFollowing.new()
			go_to_woods.target = Vector2i(51, 6)
			go_to_woods.npc = NPC
			go_to_woods.map = map
			go_to_woods._process(delta)
			set_path_line(path)
			if map.tile_position(NPC.position) == Vector2i(50, 5):
				await get_tree().create_timer(4,true,true).timeout
				set_state(State.WOODS_TWO)
		State.WOODS_TWO:
			var go_to_woods = TileFollowing.new()
			go_to_woods.target = Vector2i(25, 8)
			go_to_woods.npc = NPC
			go_to_woods.map = map
			go_to_woods._process(delta)
			set_path_line(path)
			if map.tile_position(NPC.position) == Vector2i(27, 8):
				await get_tree().create_timer(4,true,true).timeout
				set_state(State.WOODS_THREE)
		State.WOODS_THREE:
			var go_to_woods = TileFollowing.new()
			go_to_woods.target = Vector2i(45, 35)
			go_to_woods.npc = NPC
			go_to_woods.map = map
			go_to_woods._process(delta)
			set_path_line(path)
			if map.tile_position(NPC.position) == Vector2i(44, 35):
				await get_tree().create_timer(4,true,true).timeout
				set_state(State.WOODS_ONE)
			
func set_path_line(points):
	var local_points := []
	for point in points:
		if point == points[0]:
			local_points.append(Vector2.ZERO)
		else:
			local_points.append(map.game_position(point) - global_position)
	local_points.append(map.game_position(points.back())-global_position)
	pathline.points = local_points
	
func _physics_process(delta: float) -> void:
	if path.size() > 1:
		var max_speed = 150
		var start : Vector2i = path[0] * 16 + cell_size / 2
		var end : Vector2i = path[1] * 16 + cell_size / 2
		var direction = Vector2(start.x, start.y).direction_to(Vector2(end.x, end.y))
		velocity = direction * max_speed + Vector2.ONE * 8
		rotation = atan2(-velocity.x, velocity.y)
		pathline.global_rotation = 0
		move_and_slide()

		#var centered_position = path[1] * cell_size + Vector2i.ONE * cell_size/2
		#await get_tree().create_timer(0.1,true,true).timeout
		#position.x = centered_position.x
		#position.y = centered_position.y

		#rotation = atan2(-velocity.x, velocity.y)
		#pathline.global_rotation = 0
