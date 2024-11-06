class_name KinematicArrive extends Node

var end: CharacterBody2D
var start: CharacterBody2D
var max_speed: float = 0.01
var radius: float = 1
var time_to_end: float = 0.25

# Kinematic implementation of the arrive algorithm.
func kinematic_arrive() -> KinematicSteeringOutput:
	var result = KinematicSteeringOutput.new()
	
	# Calculates the velocity through the positions
	result.velocity = end.position - start.position
	
	if result.velocity.length() < radius:
		return null
		
	# Tries to get to the end in time_to_end seconds.
	result.velocity /= time_to_end
	
	# Clips to max speed if the velocity is too fast.
	if result.velocity.length() > max_speed:
		result.velocity.normalized()
		result.velocity *= max_speed
	
	# calculates new orientation in naive method.
	#start.rotation = new_orientation(
	#	start.rotation,
	#	result.velocity
	#)
	
	result.rotation = 0
	return result
	
#func new_orientation(current: float, velocity) -> float:
#	if velocity.length() > 0:
#		return atan2(-velocity.x, velocity.y)
#	else:
#		return current
