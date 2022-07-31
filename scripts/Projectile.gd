extends Sprite

export var speed = 250

var velocity = Vector2(1, 0)
var unique_dir = true

var damage

func _ready() -> void:
	if Global.player != null:
		modulate = Global.player.modulate

func _process(delta: float) -> void:
	if unique_dir:
		look_at(get_global_mouse_position())
		unique_dir = false
	
	global_position += velocity.rotated(rotation) * speed * delta

func _on_Projectile_screen_exited():
	queue_free()	
