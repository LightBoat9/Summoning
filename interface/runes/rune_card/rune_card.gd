extends PanelContainer

var can_key = true

var rune = null
var keyboard_index = 1:
	set(value):
		keyboard_index = value
		$VBoxContainer/Footer.text = "Click / Key %d" % [keyboard_index]


func set_rune(to):
	can_key = false
	
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
	
	await get_tree().create_timer(0.5).timeout
	can_key = true
	

func _input(event):
	if can_key and event is InputEventKey and event.pressed and not event.echo and (event.keycode >= KEY_1 and event.keycode <= KEY_3 or event.keycode >= KEY_KP_1 and event.keycode <= KEY_KP_3):
		var index = null
		if event.keycode >= KEY_KP_1:
			index = event.keycode % KEY_KP_1
		else:
			index = event.keycode % KEY_1
		if index == keyboard_index - 1:
			confirm()
			get_viewport().set_input_as_handled()


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		confirm()
		
func confirm():
	var player = get_tree().get_nodes_in_group("player")[0]
	for i in range(len(player.runes)):
		if not player.runes[i]:
			player.runes[i] = rune
			player.update_runes()
			break
	Globals.RunesParent.visible = false
	get_tree().paused = false
