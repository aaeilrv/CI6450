extends CharacterBody2D

var speed: float = 150  # speed in pixels/sec
var rotation_speed: float = 2
var orientation: float = 0

# Main target of the algorithms.
func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	rotation = atan2(-velocity.x, velocity.y)
	move_and_slide()
