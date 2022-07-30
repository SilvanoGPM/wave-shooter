extends Sprite

export (String) var increase_attribute
export (float) var increase_value

export (float) var cooldown_time

func _on_hitbox_area_entered(area: Area2D):
	if area.is_in_group('player') and Global.player != null:
		queue_free()

		Global.player.set(increase_attribute, increase_value)
		Global.player.powerups_cooldown.append(name)
		
		var powerup_timer = Global.player.get_node('reload_powerup_timer');
		
		powerup_timer.wait_time = cooldown_time
		powerup_timer.start()
		
