extends VBoxContainer


var index = 0:
	set(value):
		index = value
		$TextureRect.texture.region.position.x = 18 * index
	
	
func set_rune(rune):
	if rune:
		$PanelContainer/TextureButton.texture_normal = rune.get_texture()
		$PanelContainer/Label.text = str(rune.get_mana())
	else:
		$PanelContainer/TextureButton.texture_normal = null
		$PanelContainer/Label.text = ""
	
