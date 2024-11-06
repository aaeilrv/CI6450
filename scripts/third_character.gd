extends CharacterBody2D

signal state_changed(new_state)

enum State {
	GO_SLEEP,
	GO_WORK,
	GO_ENJOY,
}

@export var boredom: bool = false
@export var energy: bool = false
var time = 50

var current_state: int = State.GO_SLEEP : set = set_state
@onready var NPC: CharacterBody2D = $"."
@onready var map: Map = $"../map"
@onready var pathline = $PathLine
var path: Array

func set_state(new_state: int):
	if new_state == current_state:
		return
	else:
		current_state = new_state
		emit_signal("state_changed", current_state)

func _process(delta: float) -> void:
	match current_state:
		State.GO_WORK:
			var go_to_work = TileFollowing.new()
			go_to_work.target = Vector2(30, 04)
			go_to_work.npc = NPC
			go_to_work.map = map
			go_to_work.max_speed = 80
			go_to_work._process(delta)
			set_path_line(path)
			if map.tile_position(NPC.position) == Vector2i(30, 05):
				await get_tree().create_timer(1,true,true).timeout
				boredom = true
				if energy:
					set_state(State.GO_ENJOY)
				else:
					set_state(State.GO_SLEEP)
			else:
				pass
		State.GO_SLEEP:
			var go_to_house = TileFollowing.new()
			go_to_house.target = Vector2i(8, 28)
			go_to_house.npc = NPC
			go_to_house.map = map
			go_to_house.max_speed = 35
			go_to_house._process(delta)
			set_path_line(path)
			if map.tile_position(NPC.position) == Vector2i(10, 28) or map.tile_position(NPC.position) == Vector2i(9, 27):
				await get_tree().create_timer(3,true,true).timeout
				energy = true
				if boredom:
					set_state(State.GO_ENJOY)
				else:
					set_state(State.GO_WORK)
		State.GO_ENJOY:
			var go_fishing = TileFollowing.new()
			go_fishing.target = Vector2i(41, 36)
			go_fishing.npc = NPC
			go_fishing.map = map
			go_fishing._process(delta)
			set_path_line(path)
			if map.tile_position(NPC.position) == Vector2i(41, 35) or map.tile_position(NPC.position) == Vector2i(40, 36):
				await get_tree().create_timer(3,true,true).timeout
				boredom = false
				energy = false
				set_state(State.GO_WORK)
				
func set_path_line(points):
	var local_points := []
	for point in points:
		if point == points[0]:
			local_points.append(Vector2.ZERO)
		else:
			local_points.append(map.game_position(point) - global_position)
	local_points.append(map.game_position(points.back())-global_position)
	pathline.points = local_points
