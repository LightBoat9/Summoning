extends StaticBody2D

const Slime = preload("res://spawns/slime/slime.tscn")

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


@onready var sprite = $Sprite2D
@onready var arrow = $Arrow
@onready var arrow_shadow = $Arrow/Shadow
@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	facing = Vector2(1, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _input(event):
	if event.is_action_pressed("ui_left"):
		facing = Vector2(-1, 0)
	elif event.is_action_pressed("ui_right"):
		facing = Vector2(1, 0)
	elif event.is_action_pressed("ui_down"):
		facing = Vector2(0, 1)
	elif event.is_action_pressed("ui_up"):
		facing = Vector2(0, -1)
	elif event.is_action_pressed("ui_accept"):
		animation.play("cast_neutral")
	
	
func _on_animation_player_animation_finished(anim_name):
	if not animation:
		return
	if anim_name == "cast_neutral":
		animation.play("idle")
		var slime = Slime.instantiate()
		slime.global_position = global_position + facing * Vector2(16, 16)
		slime.direction = facing
		get_parent().add_child(slime)
