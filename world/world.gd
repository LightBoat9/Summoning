extends Node2D
	
func _ready():
	Globals.reload()


func _on_music_button_toggled(toggled_on):
	Globals.World.get_node("AudioMusic").playing = not toggled_on
