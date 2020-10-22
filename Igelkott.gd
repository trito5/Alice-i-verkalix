extends KinematicBody2D

var dead = false
var hit = 1
var intersects = false
var player = null

func _on_hurtbox_area_entered(area):
	if area.name == "sword":
		playDead()
	elif area.name == "smasher":
		get_tree().get_root().get_node("World").get_node("Message").show_general_smasher_message()
		$AudioNope.play()
		
func playDead():
	dead = true
	$AnimatedSprite.queue_free()
	$AnimatedBlood.play()
	$AnimatedBlood.set_deferred("visible", true)
	$AudioStreamPlayer.play()
	$CollisionShape2D.queue_free()
	$hurtbox.queue_free()
	$hitbox.queue_free()

func _on_hitbox_body_entered(body):
	player = body
	player.set_life(hit)
	$TimerAttack.start()
	intersects = true

func _on_hitbox_body_exited(body):
	intersects = false
	$TimerAttack.stop()

func _on_TimerAttack_timeout():
	player.set_life(hit)
