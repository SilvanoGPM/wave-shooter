extends Control

var LIFE_SIZE = 20

func on_player_hit(life: int) -> void:
	$life.rect_size.x = life * LIFE_SIZE
