extends Node2D


func _physics_process(delta):
	if Input.is_action_just_pressed("instruktioner"):
		$AudioSelect.play()
		get_tree().change_scene("res://Menu.tscn")
