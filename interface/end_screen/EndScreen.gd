extends PanelContainer


func _on_button_pressed():
	get_tree().paused = false
	SpawnManager.reset()
	get_tree().reload_current_scene()
