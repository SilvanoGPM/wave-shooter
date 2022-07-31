extends CPUParticles2D

var CLEAR_PARTICLE_OPACITY_PERCENT = 0.05

func _on_timer_timeout():
	Global.stop_node(self)

func _on_clear_timer_timeout():
	modulate.a = lerp(modulate.a, 0, 0.1)
	
	if modulate.a <= CLEAR_PARTICLE_OPACITY_PERCENT:
		queue_free()
