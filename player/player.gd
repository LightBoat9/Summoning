extends StaticBody2D

enum State {
	IDLE, CASTING, WAITING
}

const ARROW_OFFSET = [
	Vector2(12, 0),
	Vector2(0, 12),
	Vector2(-12, 0),
	Vector2(0, -12)
]

const ARROW_ROTATION = [
	0, 90, 180, 270
]

const ARROW_SHADOW_OFFSET = [
	Vector2(0, 1),
	Vector2(1, 0),
	Vector2(0, -1),
	Vector2(-1, 0)
]

var facing: Vector2 = Vector2(1, 0) :
	get:
		return facing
	set(value):
		facing = value
		sprite.flip_h = facing.x == -1
		var index = facing.angle() / (PI / 2)
		arrow.position = ARROW_OFFSET[index]
		arrow.rotation_degrees = ARROW_ROTATION[index]
		arrow_shadow.position = ARROW_SHADOW_OFFSET[index]
		raycast.target_position = facing * Vector2(16, 16)

var spawn_index = 0
var is_enemy = false
var cast_spawn_type = SpawnManager.Spawn.Slime
var max_mana = 100:
	set(value):
		max_mana = value
		update_stat_labels()
var mana = max_mana:
	set(value):
		mana = clamp(value, 0, max_mana)
		Globals.ManaBar.value = mana
		update_stat_labels()
var max_health = 100:
	set(value):
		max_health = value
		update_stat_labels()
var health = max_health:
	set(value):
		health = clamp(value, 0, max_health)
		if health <= 0:
			die()
		Globals.HealthBar.value = health
		update_stat_labels()
		
var default_health_regen = 1
var health_regen_count = default_health_regen

var default_mana_regen = 1:
	set(value):
		default_mana_regen = value
		update_stat_labels()
var mana_regen_count = 1.0/default_mana_regen
var ignore_spawns = false

var state = State.IDLE :
	set(value):
		if has_method("state_exited_%s" % State.keys()[state].to_lower()):
			call("state_exited_%s" % State.keys()[state].to_lower())
		state = value
		if has_method("state_entered_%s" % State.keys()[state].to_lower()):
			call("state_entered_%s" % State.keys()[state].to_lower())

@onready var sprite = $Sprite2D
@onready var arrow = $Arrow
@onready var arrow_shadow = $Arrow/Shadow
@onready var animation = $AnimationPlayer
@onready var raycast = $RayCast2D
@onready var shader_animation = $ShaderAnimation


var runes = [null, null, null, null, null]


# Called when the node enters the scene tree for the first time.
func _ready():
	facing = Vector2(1, 0)
	var rune = Rune.new()
	rune.rune_type = Rune.RuneType.SPAWN
	rune.rune_type_index = SpawnManager.Spawn.Slime
	runes[0] = rune
	
	Globals.reload()
	
	health = health
	mana = mana
	
	update_runes()
	
	
func update_runes():
	for i in range(len(runes)):
		Globals.Spells.get_child(i).set_rune(runes[i])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	health_regen_count -= delta
	mana_regen_count -= delta
	if health_regen_count <= 0:
		health += 1
		health_regen_count = get_health_regen()
	
	if mana_regen_count <= 0:
		mana += 1
		mana_regen_count = get_mana_regen()
	
	
func _input(event):
	if has_method("state_input_%s" % State.keys()[state].to_lower()):
		call("state_input_%s" % State.keys()[state].to_lower(), event)
	
	
func state_input_idle(event):
	input_control(event)
	if event is InputEventKey and event.pressed and not event.echo and (event.keycode >= KEY_1 and event.keycode <= KEY_9 or event.keycode >= KEY_KP_1 and event.keycode <= KEY_KP_9):
		if event.keycode >= KEY_KP_1:
			cast_spawn_type = event.keycode % KEY_KP_1
		else:
			cast_spawn_type = event.keycode % KEY_1
		if runes[cast_spawn_type] and ((runes[cast_spawn_type] and runes[cast_spawn_type].rune_type == runes[cast_spawn_type].RuneType.SPELL) or not raycast.is_colliding()):
			if mana >= runes[cast_spawn_type].get_mana():
				state = State.CASTING
			else:
				$AudioNoMana.play()
		elif raycast.is_colliding():
			$AudioBlocked.play()
	
func state_input_waiting(event):
	input_control(event)
	
func input_control(event):
	if event.is_action_pressed("ui_left"):
		facing = Vector2(-1, 0)
	elif event.is_action_pressed("ui_right"):
		facing = Vector2(1, 0)
	elif event.is_action_pressed("ui_down"):
		facing = Vector2(0, 1)
	elif event.is_action_pressed("ui_up"):
		facing = Vector2(0, -1)
		
	
func state_entered_idle():
	animation.play("idle")
	
	
func state_entered_casting():
	if not runes[cast_spawn_type]:
		state = State.IDLE
	mana -= runes[cast_spawn_type].get_mana()
	animation.play("cast_neutral")
	
	
func is_alive():
	return true
	
	
func damage(amount, ignore_shields=false):
	$AudioHurt.play()
	shader_animation.play("flash")
	health -= amount
	
	
func cast_trigger_frame():
	if not animation or runes[cast_spawn_type] == null:
		state = State.WAITING
		return
	$AudioCast.play()
	if runes[cast_spawn_type].rune_type == Rune.RuneType.SPAWN:
		var spawn = SpawnManager.get_spawn(runes[cast_spawn_type].rune_type_index)
		get_parent().add_child(spawn)
		spawn.is_enemy = false
		spawn.spawn_index = spawn_index
		spawn_index += 1
		spawn.global_position = global_position + facing * Vector2(16, 16)
		spawn.direction = facing
		state = State.WAITING
	else:
		var spell = SpellManager.get_spell(runes[cast_spawn_type].rune_type_index)
		get_parent().add_child(spell)
		spell.global_position = global_position + facing * Vector2(16, 16)
		spell.direction = facing
		state = State.WAITING


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "cast_neutral":
		state = State.IDLE
	
	
func get_health_regen():
	return 1.0/default_health_regen
	
	
func get_mana_regen():
	return 1.0/default_mana_regen
	
	
func die():
	Globals.end_game()
	
	
func update_stat_labels():
	Globals.ManaBarLabel.text = "%d/%d +%.1f/sec" % [mana, max_mana, default_mana_regen]
	Globals.HealthBarLabel.text = "%d/%d +%.1f/sec" % [health, max_health, default_health_regen]
