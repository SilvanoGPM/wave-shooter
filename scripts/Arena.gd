extends Node2D

var MIN_ENEMY_SPAWN_TIME = 0.5
var ENEMY_SPAWN_DIFFICULTY_INCREMENT = 0.025

export (Array, PackedScene) var enemies 

func _ready() -> void:
	randomize()

	Global.score = 0
	Global.global_parent = self

func _exit_tree() -> void:
	Global.global_parent = null

func get_random_enemy_pos() -> Vector2:
	var enemy_pos = Vector2(rand_range(-160, 670), rand_range(-90, 390))
	
	if enemy_pos.x < 640 and enemy_pos.x > -80 and enemy_pos.y < 360 and enemy_pos.y > -45:
		return get_random_enemy_pos()

	return enemy_pos

func _on_enemy_spawn_timer_timeout() -> void:
	var enemy_pos = get_random_enemy_pos()

	var enemy = enemies[randi() % enemies.size()]

	Global.instance_node(enemy, enemy_pos, self)

func _on_difficulty_timer_timeout():
	if $enemy_spawn_timer.wait_time > MIN_ENEMY_SPAWN_TIME:
		$enemy_spawn_timer.wait_time -= ENEMY_SPAWN_DIFFICULTY_INCREMENT
