extends StaticBody2D

enum State {
	MOVE, ATTACK, STUNNED
}

const DIRECTION_NAME = {
	Vector2(1, 0): "right",
	Vector2(-1, 0): "left",
	Vector2(0, 1): "up",
	Vector2(0, -1): "down"
}

var stopped = false
var spawn_index = 0
var is_enemy = false :
	set(value):
		is_enemy = value
		set_collision_layer_value(1, not is_enemy)
		set_collision_layer_value(2, is_enemy)
		
		move_raycast.set_collision_mask_value(3, 0)
		attack_raycast.set_collision_mask_value(3, 0)
		
		attack_raycast.set_collision_mask_value(1, is_enemy)
		attack_raycast.set_collision_mask_value(2, not is_enemy)


var sprite_texture:
	set(value):
		sprite_texture = value
		$Sprite2D.texture = sprite_texture

var range = 16
var direction = Vector2(1, 0) :
	set(value):
		direction = value
		_update_raycast_direction()
		if sprite:
			sprite.flip_h = direction.x < 0
		
		
var state = State.MOVE :
	set(value):
		if has_method("state_exited_%s" % State.keys()[state].to_lower()):
			call("state_exited_%s" % State.keys()[state].to_lower())
		state = value
		if has_method("state_entered_%s" % State.keys()[state].to_lower()):
			call("state_entered_%s" % State.keys()[state].to_lower())

var base_damage = 5
var move_speed = 8

var max_health = 20 :
	set(value):
		max_health = value
		if health > max_health:
			health = max_health
		healthbar_draw.queue_redraw()
var health = max_health :
	set(value):
		health = clamp(value, 0, max_health)
		healthbar_draw.queue_redraw()
		if health <= 0:
			health = 0
			die()
	
var max_shield = 0
var shield = 0:
	set(value):
		shield = max(0, value)
		healthbar_draw.queue_redraw()
	
var mana_cost = 10
			
var attack_target = null

var spawn_manager = null

var ignore_spawns = false:
	set(value):
		ignore_spawns = value
		set_collision_mask_value(1, 0)
		set_collision_mask_value(2, 0)
		
var collision_damage = 0
var colliders_damaged = []

@onready var move_raycast = $AttackRayCast
@onready var attack_raycast = $MoveRayCast
@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var shader_animation = $ShaderAnimation
@onready var healthbar_draw = $HealthbarDraw
@onready var audio_hit = $AudioHit

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_raycast_direction()
	if spawn_manager and spawn_manager.has_method("spawn_initialize"):
		spawn_manager.spawn_initialize(self)
	update_max_shield()
	
	
func _update_raycast_direction():
	if move_raycast:
		move_raycast.position = Vector2(8, 8) * -direction
		move_raycast.target_position = Vector2(16, 16) * direction
	if attack_raycast:
		attack_raycast.position = Vector2(8, 8) * -direction
		attack_raycast.target_position = Vector2(range, range) * direction


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if has_method("state_process_%s" % State.keys()[state].to_lower()):
		call("state_process_%s" % State.keys()[state].to_lower(), delta)
			
			
func update_max_shield():
	max_shield = shield
			
func die():
	if is_enemy:
		Globals.add_points(mana_cost)
	if spawn_manager and spawn_manager.has_method("spawn_on_death"):
		spawn_manager.spawn_on_death(self)
	queue_free()
	
	
func state_entered_move():
	animation.play("idle")
	
	
func state_entered_stunned():
	animation.play("stunned")
	
	
func state_entered_attack():
	attack_target = attack_raycast.get_collider()
	if not attack_target or not attack_target.is_alive():
		state = State.MOVE
		return
	animation.play("attack_%s" % DIRECTION_NAME[direction])
	
	
func state_exited_attack():
	attack_target = null
	
	
func state_process_move(delta):
	var has_collision = false
	if attack_raycast.is_colliding() or move_raycast.is_colliding():
		var attack_collider = attack_raycast.get_collider()
		var move_collider = move_raycast.get_collider()
		
		if move_collider or (attack_collider and attack_collider.has_method("is_alive") and attack_collider.is_alive()):
			if is_enemy and ignore_spawns and attack_collider == Globals.Player:
				die()
				
			has_collision = true
			
			if attack_collider and attack_collider.is_enemy != is_enemy:
				if ignore_spawns:
					has_collision = false
					if not attack_collider in colliders_damaged and collision_damage > 0:
						attack_collider.damage(collision_damage, true)
						colliders_damaged.append(attack_collider)
						play_collide()
				elif not attack_collider.ignore_spawns:
					state = State.ATTACK
					if spawn_manager and spawn_manager.has_method("spawn_collide_enemy"):
						spawn_manager.spawn_collide_enemy(self, attack_collider)
				else:
					has_collision = false
			elif not move_collider:
				has_collision = false
				stopped = false
			elif move_collider and (ignore_spawns or move_collider.ignore_spawns):
				has_collision = false
				if move_collider.is_enemy == is_enemy and spawn_manager and spawn_manager.has_method("spawn_collide_friendly"):
					spawn_manager.spawn_collide_friendly(self, move_collider)
				stopped = false
			elif move_collider and "spawn_index" in move_collider and move_collider.spawn_index > spawn_index:
				has_collision = false
				stopped = false
	else:
		stopped = false
				
	if not has_collision and (not stopped or ignore_spawns):
		if is_enemy or abs(global_position) < abs(direction) * 16 * 6.5 or ignore_spawns:
			global_position += direction * delta * move_speed
		
		if not is_enemy and abs(global_position) >= abs(direction) * 16 * 9 and ignore_spawns:
			die()
	
	if has_collision:
		stopped = true


func _on_animation_player_animation_finished(anim_name):
	if anim_name.begins_with("attack"):
		state = State.MOVE
	elif anim_name == "stunned":
		state = State.MOVE
	
	
func is_alive():
	return not is_queued_for_deletion() and health > 0
	
	
func attack_animation_frame():
	if is_alive() and not attack_target == null and not attack_target.is_queued_for_deletion() and attack_target.is_alive():
		audio_hit.play()
		attack_target.damage(base_damage)
	
	
func damage(amount, ignore_shields=false):
	shader_animation.play("flash")
	var post_mitigated = amount
	if not ignore_shields:
		if amount >= shield:
			post_mitigated -= shield
		shield -= amount
	if shield <= 0:
		health -= post_mitigated
	
	
func play_collide():
	$AudioCollision.play()
