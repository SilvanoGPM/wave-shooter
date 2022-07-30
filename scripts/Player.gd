extends Sprite

export var speed = 150

var PLAYER_SIZE = 12
var SCREEN_MAX_X = 628
var SCREEN_MAX_Y = 348

var velocity = Vector2.ZERO
var can_shoot = true
var dead = false

var default_reload_time = 0.1
var reload_time = default_reload_time

var default_damage = 1
var damage = default_damage

var powerups_cooldown = []

var projectile = preload("res://scenes/Projectile.tscn")

func _ready() -> void:
	Global.player = self

func _exit_tree() -> void:
	Global.player = null

func get_direction(x: String, y: String) -> int:
	return int(Input.is_action_pressed(x)) - int(Input.is_action_pressed(y))

func process_velocity(delta: float) -> void:	
	velocity.x = get_direction('ui_right', 'ui_left')
	velocity.y = get_direction('ui_down', 'ui_up')

	var pos = global_position + (speed * velocity * delta)

	global_position.x = clamp(pos.x, PLAYER_SIZE, SCREEN_MAX_X)
	global_position.y = clamp(pos.y, PLAYER_SIZE, SCREEN_MAX_Y)

func control_shoot() -> void:
	if Input.is_action_pressed('shoot') and Global.global_parent and can_shoot:
		var projectile_instance = Global.instance_node(projectile, global_position)
		
		projectile_instance.damage = damage
		
		can_shoot = false
		$reload_timer.start()

func _process(delta: float) -> void:
	if not dead:
		process_velocity(delta)
		
		control_shoot()

func _on_reload_timer_timeout():
	can_shoot = true
	$reload_timer.wait_time = reload_time

func _on_hitbox_area_entered(area: Area2D):
	if area.is_in_group('enemy'):
		visible = false
		dead = true
		
		$restart_timer.start()

func _on_restart_timer_timeout():
	get_tree().reload_current_scene()

func _on_reload_powerup_timer_timeout():
	print(powerups_cooldown)
	
	if 'ReloadPowerUp' in powerups_cooldown:
		reload_time = default_reload_time
		powerups_cooldown.erase('ReloadPowerUp')
		
	if 'DamagePowerUp' in powerups_cooldown:
		damage = default_damage
		powerups_cooldown.erase('DamagePowerUp')
	
