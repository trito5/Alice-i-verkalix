extends Node2D


func _on_Area_body_entered(body):
	get_tree().get_root().get_node("World").get_node("GameClearedCanvas").game_cleared()
	$AudioCoffee.play()
	$coffee.set_deferred("visible", true)
	$Area.queue_free()
	body.hasWon = true
