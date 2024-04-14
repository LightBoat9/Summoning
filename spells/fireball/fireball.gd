extends Area2D

var direction = Vector2(1, 0)

var triggered = false

@onready var sprite = $Sprite2D
@onready var particles = $CPUParticles2D
@onready var shadow = $Shadow

func _on_body_entered(body):
	if not triggered:
		if body and not body.is_queued_for_deletion() and body.is_alive():
			body.damage(SpellManager.SPELL_DAMAGE[SpellManager.Spells.Fireball])
			triggered = true
			sprite.visible = false
			shadow.visible = false
			particles.emitting = false
			await get_tree().create_timer(1.0).timeout
			queue_free()
	
	
func _process(delta):
	if not triggered:
		position += direction * delta * 32
