extends PanelContainer


var rune = null


func set_rune(to):
	rune = to
	
	$VBoxContainer/TextureRect.texture = rune.get_texture()
	$VBoxContainer/Title.text = rune.get_title()
	$VBoxContainer/Description.text = rune.get_description()
	
	var damage = rune.get_damage()
	var health = rune.get_health()
	var shield = rune.get_shield()
	var mana = rune.get_mana()
	
	$VBoxContainer/HB/HB/Label.text = str(health)
	$VBoxContainer/HB/HB.visible = health > 0
	
	$VBoxContainer/HB/HB2/Label.text = str(damage)
	$VBoxContainer/HB/HB2.visible = damage > 0
	
	$VBoxContainer/HB/HB3/Label.text = str(shield)
	$VBoxContainer/HB/HB3.visible = shield > 0
	
	$VBoxContainer/HB/HB4/Label.text = str(mana)
	$VBoxContainer/HB/HB4.visible = mana > 0


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var player = get_tree().get_nodes_in_group("player")[0]
		for i in range(len(player.runes)):
			if not player.runes[i]:
				player.runes[i] = rune
				player.update_runes()
				break
		Globals.RunesParent.visible = false
		get_tree().paused = false
