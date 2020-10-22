extends KinematicBody2D

var velocity = Vector2.ZERO
const SPEED = 1800
var player = null
var dead = false
var hit = 1
var intersects = false

func _physics_process(delta):
	velocity = Vector2.ZERO
	if player and not dead:
		velocity = position.direction_to(player.position) * SPEED * delta
		display_direction(velocity.x) 
	
	velocity = move_and_slide(velocity)


func _on_hurtbox_area_entered(_area):
	if _area.name == "smasher":
		play_mosquito_dead()
			
	elif _area.name == "sword":
		get_tree().get_root().get_node("World").get_node("Message").show_mosquito_message()
		$AudioNope.play()

func _on_AnimatedBlood_animation_finished():
	$AnimatedBlood.queue_free()

func _on_AnimatedSprite_animation_finished():
	pass
	
func display_direction(direction):
	if (direction < 0):
		$AnimatedSprite.set_deferred("flip_h", false)
	else: 
		$AnimatedSprite.set_deferred("flip_h", true)

func play_mosquito_dead():
	dead = true
	$AudioStreamPlayer.play()
	$AnimatedBlood.set_deferred("visible", true)
	$AnimatedBlood.play()
	$CollisionShape2D.queue_free()
	$CollisionShape2D/mosquito_hurtbox/CollisionShape2D.queue_free()
	$hitbox.queue_free()
	$AnimatedSprite.queue_free()
	

func _on_Area2D_body_entered(body):
	player = body

func _on_Area2D_body_exited(body):
	player = null

func _on_hitbox_body_entered(alice):
	alice.set_life(hit)
	intersects = true
	$Timer.start()

func _on_hitbox_body_exited(body):
	intersects = false
	$Timer.stop()

func _on_Timer_timeout():
	if intersects:
		player.set_life(hit)
