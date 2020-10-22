extends Control

func add_heart(life):
	$AudioStreamPlayer2D.play()
	set_heart(life)

func set_heart(life):
	if life == 3:
		$Heart1.set_deferred("visible", true)
		$Heart2.set_deferred("visible", true)
		$Heart3.set_deferred("visible", true)
	elif life == 2:
		$Heart1.set_deferred("visible", true)
		$Heart2.set_deferred("visible", true)
		$Heart3.set_deferred("visible", false)
	elif life == 1:
		$Heart1.set_deferred("visible", true)
		$Heart2.set_deferred("visible", false)
		$Heart3.set_deferred("visible", false)
	else:
		$Heart1.set_deferred("visible", false)
		$Heart2.set_deferred("visible", false)
		$Heart3.set_deferred("visible", false)

