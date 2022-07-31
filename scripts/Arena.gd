extends Node2D

export (Array, PackedScene) var enemies 
export (Array, PackedScene) var powerups

var MIN_ENEMY_SPAWN_TIME = 0.5
var ENEMY_SPAWN_DIFFICULTY_INCREMENT = 0.025

func _ready() -> void:
	randomize()

	Global.score = 0
	Global.global_parent = self

func _exit_tree() -> void:
	Global.global_parent = null

func get_random_enemy_pos() -> Vector2:
	var enemy_pos = Global.random_pos_in_screen(true)
	
	if enemy_pos.x < 640 and enemy_pos.x > -80 and enemy_pos.y < 360 and enemy_pos.y > -45:
		return get_random_enemy_pos()

	return enemy_pos

func _on_enemy_spawn_timer_timeout() -> void:
	Global.create_spawnner(enemies, self, get_random_enemy_pos())

func _on_difficulty_timer_timeout():
	if $enemy_spawn_timer.wait_time > MIN_ENEMY_SPAWN_TIME:
		$enemy_spawn_timer.wait_time -= ENEMY_SPAWN_DIFFICULTY_INCREMENT

func _on_powerup_spawn_timer_timeout():
	Global.create_spawnner(powerups, self)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		Global.save_game()
