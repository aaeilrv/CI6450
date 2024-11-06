extends CharacterBody2D

signal state_changed(new_state)

enum State {
	SHOPPING,
	STORING,
	GETTING_MONEY,
	WANDERING
}

@export var storage: bool = true
@export var coins: bool = true
var time = 50

var current_state: int = State.SHOPPING : set = set_state
@onready var NPC: CharacterBody2D = $"."
@onready var map: Map = $"../map"
var path: Array
@onready var pathline = $PathLine
@export var cell_size = Vector2i(16, 16)

func set_state(new_state: int):
	if new_state == current_state:
		return
	else:
		current_state = new_state
		emit_signal("state_changed", current_state)

func _process(delta: float) -> void:
	match current_state:
		State.SHOPPING:
			if coins == true and storage == true:
				var go_to_store = TileFollowing.new()
				go_to_store.target = Vector2(28, 20)
				go_to_store.npc = NPC
				go_to_store.map = map
				go_to_store.max_speed = 60
				go_to_store._process(delta)
				set_path_line(path)
				if map.tile_position(NPC.position) == Vector2i(29, 20):
					await get_tree().create_timer(0.7,true,true).timeout
					coins = false
					storage = false
					set_state(State.GETTING_MONEY)
			else:
				pass
		State.GETTING_MONEY:
			var go_to_house = TileFollowing.new()
			go_to_house.target = Vector2i(64, 6)
			go_to_house.npc = NPC
			go_to_house.map = map
			go_to_house._process(delta)
			set_path_line(path)
			if map.tile_position(NPC.position) == Vector2i(64, 7):
				await get_tree().create_timer(0.8,true,true).timeout
				coins = true
				if storage == false:
					set_state(State.STORING)
				else:
					set_state(State.SHOPPING)
		State.STORING:
			var go_to_chest = TileFollowing.new()
			go_to_chest.target = Vector2i(43, 6)
			go_to_chest.npc = NPC
			go_to_chest.map = map
			go_to_chest.max_speed = 80
			go_to_chest._process(delta)
			set_path_line(path)
			if map.tile_position(NPC.position) == Vector2i(43, 7):
				await get_tree().create_timer(0.2,true,true).timeout
				storage = true
				if coins == false:
					set_state(State.GETTING_MONEY)
				else:
					set_state(State.SHOPPING)

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
		#var start : Vector2i = npc.path[0] * 16 + cell_size / 2
		#var end : Vector2i = npc.path[1] * 16 + cell_size / 2
		#var direction = Vector2(start.x, start.y).direction_to(Vector2(end.x, end.y))
		#npc.velocity = direction * max_speed + Vector2.ONE * 8
		
		var centered_position = path[1] * cell_size + Vector2i.ONE * cell_size/2
		await get_tree().create_timer(0.1,true,true).timeout
		position.x = centered_position.x
		position.y = centered_position.y

		rotation = atan2(-velocity.x, velocity.y)
		pathline.global_rotation = 0
