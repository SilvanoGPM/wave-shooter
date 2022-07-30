extends CPUParticles2D

func _on_timer_timeout():
	Global.stop_node(self)
