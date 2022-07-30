extends Sprite

export var speed = 75
export var hp = 3

var velocity = Vector2.ZERO
var stunned = false
var knockback = 6

var default_color = null

var blood_particle = preload('res://scenes/BloodParticle.tscn')

func _ready() -> void:
	default_color = modulate

func follow_player(delta: float) -> void:
	if Global.player != null and not stunned:
		velocity = global_position.direction_to(Global.player.global_position)
	elif stunned:
		velocity = lerp(velocity, Vector2.ZERO, 0.3)
	
	global_position += velocity * speed * delta

func control_life() -> void:
	if hp <= 0 and Global.global_parent:
		if Global.camera != null:
			Global.camera.shake_screen(50, 0.1)
		
		var particle = Global.instance_node(blood_particle, global_position)
		
		particle.rotation = velocity.angle()
		
		queue_free()

		Global.score += 10

func _process(delta: float) -> void:
	follow_player(delta)

	control_life()

func _on_hitbox_area_entered(area: Area2D):
	if area.is_in_group('damage') and not stunned:
		area.get_parent().queue_free()
		
		hp -= 1
		stunned = true	
		velocity = -velocity * knockback
		
		modulate = Color.white
		$stunned_timer.start()

func _on_stunned_timer_timeout():
	modulate = default_color
	stunned = false
