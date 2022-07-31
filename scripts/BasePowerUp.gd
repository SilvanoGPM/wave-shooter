extends Sprite

export (String) var increase_attribute
export (float) var increase_value

export (float) var cooldown_time

func _on_hitbox_area_entered(area: Area2D):
	if area.is_in_group('player'):
		queue_free()

		var parent = area.get_parent()

		parent.set(increase_attribute, increase_value)
		parent.powerups_cooldown.append(name)
		
		var powerup_timer = parent.get_node('reload_powerup_timer');
		
		powerup_timer.wait_time = cooldown_time
		powerup_timer.start()
		
		parent.modulate = modulate
