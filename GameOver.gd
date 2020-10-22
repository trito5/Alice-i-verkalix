extends Node2D


func setGameOver(isGameOver):
	if isGameOver:
		self.set_deferred("visible", true)
		get_tree().get_root().get_node("World").get_node("AudioStreamPlayer").set_deferred("playing", false)
		$GameOverSong.play()
		

func _on_GameOverSong_finished():
	get_tree().change_scene("res://Menu.tscn")
