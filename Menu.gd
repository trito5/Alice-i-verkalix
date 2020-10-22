extends Node2D
var hasShownGameStory = false

func _ready():
	$AudioMain.play()

func _physics_process(delta):
	if Input.is_action_just_pressed("play"):
		$Play.play()
		if hasShownGameStory:
			get_tree().change_scene("res://World.tscn")
		else:
			$Game_story.set_deferred("visible", true)
			hasShownGameStory = true
	
	if Input.is_action_just_pressed("instruktioner") and not hasShownGameStory:
		$Game_story.set_deferred("visible", false)
		$Play.play()
		toggle_instructions()
	
func toggle_instructions():
	var param = not $instructions.visible
	$instructions.set_deferred("visible", param)
