extends CanvasLayer

func game_cleared():
	print("cleared")
	$GameCleared.set_deferred("visible", true)
	$GameCleared/GameCleared.set_deferred("visible", true)
