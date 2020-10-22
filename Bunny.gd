extends KinematicBody2D

var direction = 1
var velocity = Vector2.ZERO
const SPEED = 1300

func _process(delta):
	display_direction(velocity.x)
	velocity.x = direction * SPEED * delta
	velocity = move_and_slide(velocity)
	

func display_direction(direction):
	if (direction < 0):
		$Bunny.set_deferred("flip_h", true)
	else: 
		$Bunny.set_deferred("flip_h", false)


func _on_Timer_timeout():
	direction = -direction
