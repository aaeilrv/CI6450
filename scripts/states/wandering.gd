class_name Wandering extends Node

var move_direction: Vector2
var wander_time: float
var move_speed = 10

var npc: CharacterBody2D
var map

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * 16
	wander_time = randf_range(1, 3) * 10

func _physics_process(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
		physics_update(delta)
		
func physics_update(delta: float):
	var map_position = map.tile_position(move_direction)
	var valid_direction = map.validTile(Vector2i(map_position.x + 36, map_position.y + 20))
	if npc and valid_direction:
		npc.velocity = move_direction * move_speed
	else:
		randomize_wander()
	npc.move_and_slide()
