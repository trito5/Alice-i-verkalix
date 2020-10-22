extends StaticBody2D

func _on_hurtbox_body_entered(player):
	if player.getLife() != 3:
		$bush_lingon.set_deferred("visible", false)
		$hurtbox.queue_free()
		player.addHeart()
