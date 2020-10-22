extends KinematicBody2D

var velocity = Vector2.ZERO
var dead = false
var player = null
var direction = Vector2.ZERO
var knockback = Vector2.ZERO
var hit = 1
var life = 3
var SPEED = 1200
var intersects = false

func _ready():
	velocity.x = 1
	$Timer.start()
	change_direction()

func _physics_process(delta):
	
	velocity = Vector2.ZERO

	if not dead:
		if player and life < 3:
			velocity = position.direction_to(player.position) * SPEED * 1.1 * delta
		else:
			velocity = velocity.move_toward(direction, SPEED * delta)
		display_direction(velocity.x)	
		knockback = knockback.move_toward(Vector2.ZERO, SPEED * delta)
		knockback = move_and_slide(knockback)
		
		velocity = move_and_slide(velocity)
		
	

func display_direction(direction):

	if (direction < 0):
		$AnimatedMoose.set_deferred("flip_h", false)
	else: 
		$AnimatedMoose.set_deferred("flip_h", true)


func _on_Timer_timeout():
	change_direction()

func change_direction():
	direction.x = rand_range(-100, 100)
	direction.y = rand_range(-100, 100)


func _on_hitbox_body_entered(player):
	player.set_life(hit)
	$TimerAttack.start()
	
func _on_hitbox_body_exited(body):
	$TimerAttack.stop()
	
func _on_TimerAttack_timeout():
	player.set_life(hit)

func _on_hurtbox_area_entered(area):
	if area.name == "sword":
		$AudioHit.play()
		life -= 1
		if life == 0:
			play_dead_scene()
		else:
			knockback = area.knockback_vector * 200
	elif area.name == "smasher":
		get_tree().get_root().get_node("World").get_node("Message").show_moose_message()
		$AudioNope.play()
	
		
func play_dead_scene():
	dead = true
	$AnimatedBlood.play()
	$AnimatedBlood.set_deferred("visible", true)
	$AnimatedMoose.queue_free()
	$CollisionShape2D.queue_free()
	$hitbox.queue_free()
	$hurtbox.queue_free()
	$Timer.queue_free()


func _on_huntbox_body_entered(body):
	player = body
	

func _on_huntbox_body_exited(body):
	player = null


