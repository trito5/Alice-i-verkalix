extends CanvasLayer

func show_sword_message():
	$Message/Sword.set_deferred("visible", true)
	$Timer.start()

func show_smasher_message():
	$Message/Smasher.set_deferred("visible", true)
	$Timer.start()
	
func show_bear_message():
	$Message/Bear.set_deferred("visible", true)
	$Timer.start()
	
func show_moose_message():
	$Message/Moose.set_deferred("visible", true)
	$Timer.start()
	
func show_mosquito_message():
	$Message/Mosquito.set_deferred("visible", true)
	$Timer.start()
	
func show_general_smasher_message():
	$Message/GeneralSmasher.set_deferred("visible", true)
	$Timer.start()

func show_stop_message():
	$Message/Stop.set_deferred("visible", true)
	$Timer.start()
	
func show_skate_message():
	$Message/Skates.set_deferred("visible", true)
	$Timer.start()
	
func _on_Timer_timeout():
	$Message/Sword.set_deferred("visible", false)
	$Message/Smasher.set_deferred("visible", false)
	$Message/Bear.set_deferred("visible", false)
	$Message/Moose.set_deferred("visible", false)
	$Message/Mosquito.set_deferred("visible", false)
	$Message/GeneralSmasher.set_deferred("visible", false)
	$Message/Stop.set_deferred("visible", false)
	$Message/Skates.set_deferred("visible", false)
	

func _on_TriggerMessage_body_entered(body):
	self.show_stop_message()
