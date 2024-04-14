extends VBoxContainer


var index = 0:
	set(value):
		index = value
		$TextureRect.texture.region.position.x = 9 * index
	
	
func set_rune(rune):
	if rune:
		$PanelContainer/TextureButton.texture_normal = rune.get_texture()
	else:
		$PanelContainer/TextureButton.texture_normal = null
	
